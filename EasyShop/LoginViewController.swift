//
//  LoginViewController.swift
//  EasyShop
//
//  Created by user163874 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
  
    @IBOutlet weak var txtpassword: UITextField!
     
     @IBOutlet weak var txtUserName: UITextField!
    
    static var userNameId  : String?
    
    var shouldLogin=""
    
    @IBAction func logIn(_ sender: UIButton) {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        
        request.returnsObjectsAsFaults = false
        
        if txtpassword.text! == "" || txtUserName.text! == ""
        {
                let alert = UIAlertController(title: "Login", message: "Please enter values", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        else{
            do{
                let result = try context.fetch(request)
               
                for data in result as! [NSManagedObject]
                {
                    let userNameData = data.value(forKey: "username") as? String
                    let passwordData = data.value(forKey: "password") as? String
                    LoginViewController.self.userNameId = txtUserName.text
                    if txtUserName.text ==  userNameData
                    {
                        if txtpassword.text == passwordData
                        {
                            shouldLogin="yes"
                        }
                        else{
                            let alert = UIAlertController(title: "Login", message: "Login Un-Successful", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            shouldLogin="no"
                           shouldPerformSegue(withIdentifier: "seg1", sender: self)
                            
                           
                        }
                    }
                }
            }
            catch{ let alert = UIAlertController(title: "Login", message: "Login Un-Successful", preferredStyle: UIAlertController.Style.alert)
                                       alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                                       self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vc  = segue.destination as! HomeViewController
        
               }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(shouldLogin=="yes")
        {
            return true;
        }
        return false
    }
  
    @IBOutlet weak var imageLogo: UIImageView!
    
   
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                  view.endEditing(true)
                  super.touchesBegan(touches, with: event)
              }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
