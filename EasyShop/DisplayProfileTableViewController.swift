//
//  DisplayProfileViewController.swift
//  Project
//
//  Created by user163874 on 8/4/20.
//  Copyright © 2020 user163874. All rights reserved.
//

import UIKit
import CoreData

class DisplayProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(LoginViewController.userNameId)")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        request.returnsObjectsAsFaults = false
        
        do{
         let result = try context.fetch(request)
         for data in result as! [NSManagedObject]
         {
             let userNameData = data.value(forKey: "username") as! String
         
            if LoginViewController.userNameId ==  userNameData
             {
                print("inside----------------------------------")
                userName.text=data.value(forKey: "username") as? String
                
                email.text=data.value(forKey: "email") as? String
                
                name.text=data.value(forKey: "name") as? String
                
            }
        }
    }
        catch{}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
