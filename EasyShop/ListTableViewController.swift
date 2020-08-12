//
//  ListTableViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/4/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController  {
  
   
        //Creating array from db class product
        var ProductArray = [Item]()
    var billItemArray = [BillItem]()
    
    var totalamount : Double = 0
    
    
      var selectedCategory : Category? {
          didSet{
              loadItems()
          }
      }
        
        //creating context to load our conatainer db from delegates as object
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
        //display function
        //  loadItems()
        

           
       }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            context.delete(ProductArray[indexPath.row])
            ProductArray.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    
        
    }
    
   
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let vc  = segue.destination as! ResultViewController
        vc.billitemArrayResult = self.billItemArray
       }
    
    
    
    @IBAction func myDonebtn(_ sender: UIBarButtonItem) {
        
        
        for p in ProductArray {
            
            if p.status == true {
                var item = BillItem()
                item.itemName = p.name!
                item.itemQantity = Int(p.quantity!)
                billItemArray.append(item)
            }
                
            
        }
        
        performSegue(withIdentifier: "list", sender: self)
        
//        let alert = UIAlertController(title: "Total", message: "\(totalamount)", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
        // MARK: - Table view data source

        //loading data as per number of items in array
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return ProductArray.count
           }
    
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let alert = UIAlertController(title: "Add Product Price", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        
        
        
        alert.textFields![0].placeholder = "Enter Price"
        alert.textFields![0].keyboardType = UIKeyboardType.decimalPad
        
    
        alert.addAction(UIAlertAction(title: "Enter Price", style: .default , handler:{(action) in
            self.totalamount += (Double(alert.textFields![0].text!)! * Double(self.ProductArray[indexPath.row].quantity!)!)
            
            for p in self.billItemArray{
                
                if p.itemName == self.ProductArray[indexPath.row].name{
                    p.price = (Double(alert.textFields![0].text!))!
                    
                }
            }
        

        }))
        
        self.present(alert, animated: true)
        
                        
       ProductArray[indexPath.row].status = !ProductArray[indexPath.row].status
        saveItems()
        var temp : Item?
        
      //  temp = ProductArray[indexPath.row]
        temp = ProductArray.remove(at: indexPath.row)
        
    //    ProductArray[indexPath.row] =  ProductArray[ProductArray.count-1]
    //    ProductArray[ProductArray.count-1] = temp!
        ProductArray.append(temp!)
        
        
        
        
        
        print("\(ProductArray[indexPath.row])")
          //  saveItems()
            
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
            
        }
    
         //conf the cell with items from array
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
               
             //  let product = ProductArray[indexPath.row]
               
           // cell.textLabel?.text = product.name
        //  cell.textLabel?.text = product.quantity
            
            //  let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
                    cell.textLabel?.text = ProductArray[indexPath.row].name
                        cell.detailTextLabel!.text = ProductArray[indexPath.row].quantity
            
            cell.accessoryType = ProductArray[indexPath.row].status ? .checkmark : .none

               return cell
           }
        
        
        
        
         //MARK: - TableView Delegate Methods
           
        //bar button action to create new item
         
    @IBAction func mybutton(_ sender: UIBarButtonItem) {
    
    
     let alert = UIAlertController(title: "Add New Product", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        alert.addTextField()
        
        
        alert.textFields![0].placeholder = "Enter Item"
        alert.textFields![0].keyboardType = UIKeyboardType.alphabet
        
        alert.textFields![1].placeholder = "Enter Qantity"
        alert.textFields![1].keyboardType = UIKeyboardType.alphabet
        
        
        alert.addAction(UIAlertAction(title: "Add Product", style: .default , handler:{(action) in
            
             let newProduct = Item(context: self.context)
            newProduct.name = alert.textFields![0].text
            newProduct.quantity = alert.textFields![1].text
            newProduct.parentCategory = self.selectedCategory
            self.ProductArray.append(newProduct)
            
            self.saveItems()

        }))
        
        self.present(alert, animated: true)
        
    }
        
       
    
      
        
        //Saving data into db using save
        func saveItems() {
            
            do {
              try context.save()
            } catch {
               print("Error saving context \(error)")
            }
            
            self.tableView.reloadData()
        }
        
        //loading data from db using nsfectchrequest
       func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
           
           let categoryPredicate = NSPredicate(format: "parentCategory.categoryname MATCHES %@", selectedCategory!.categoryname!)
           
           if let addtionalPredicate = predicate {
               request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
           } else {
               request.predicate = categoryPredicate
           }

           
           do {
               ProductArray = try context.fetch(request)
           } catch {
               print("Error fetching data from context \(error)")
           }
           
           tableView.reloadData()
           
       }
    
    

}


extension ListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<Item> = Item.fetchRequest()
    
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
        }
    }
}



