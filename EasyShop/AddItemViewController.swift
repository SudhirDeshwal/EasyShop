//
//  AddItemViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/4/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    
    @IBOutlet weak var ItemName: UITextField!
    @IBOutlet weak var ItemQuantity: UITextField!
    
    var item: Item?
    var myCDManager = CDManager()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    
    
    @IBAction func Save(_ sender: Any) {
        
        var name = ItemName.text!
        var quantity = ItemQuantity.text!
        
        let alert = UIAlertController(title: "Add Item", message: "Are you sure you want to Add \(name) in List?", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Save", style: .default){
            (action) in
            self.myCDManager.saveItem(name: name, quantity: quantity)
           self.myCDManager.fetchItems()
            var tableview = ListTableViewController()
            tableview.tableView.reloadData()
            
        }
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    

    @IBAction func Cancel(_ sender: Any) {
        
        ItemName.text = ""
        ItemQuantity.text = ""
        
    }
    

}
