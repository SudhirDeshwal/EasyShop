//
//  CDManager.swift
//  EasyShop
//
//  Created by user165333 on 8/4/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import Foundation
import CoreData

class CDManager {
    
    
    // for save item
    func saveItem(name: String, quantity: String){
        let newItem = Item(context: persistentContainer.viewContext)
        
        newItem.name = name
        newItem.quantity = quantity
        
        saveContext()
    }
    //for all items
    
    func fetchItems() -> [Item]{
        let fetch: NSFetchRequest = Item.fetchRequest()
        
        var results = [Item]()
        
        do {
            results = try persistentContainer.viewContext.fetch(fetch)
        }catch {
            
        }
        return results
    }
   
    //for filter in search bar
    

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "EasyShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
