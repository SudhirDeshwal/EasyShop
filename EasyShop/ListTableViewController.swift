//
//  ListTableViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/4/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController ,UISearchBarDelegate {
    

   var dbManager = CDManager()
    var allDBUsers = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allDBUsers = dbManager.fetchItems()
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allDBUsers = dbManager.fetchItems()
        self.tableView.reloadData()
        
    }
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return allDBUsers.count
       }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
            cell.textLabel?.text = allDBUsers[indexPath.row].name
                  cell.detailTextLabel!.text = allDBUsers[indexPath.row].quantity
           // Configure the cell...

           return cell
       }
    

    //for search bar
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
              print(searchBar.text ?? "")
        allDBUsers = dbManager.fetchUser(name: searchBar.text!)
              self.tableView.reloadData()
    
          }
    

    
}
