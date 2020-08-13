//
//  SignUpViewController.swift
//  EasyShop
//
//  Created by user163874 on 8/13/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//
import UIKit

import CoreData

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var conPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtname: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    func getData(userName : String)-> Bool
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        request.returnsObjectsAsFaults = false
        
        do{
                   let result = try context.fetch(request)
                  
                   for data in result as! [NSManagedObject]
                   {
                       let userNameData = data.value(forKey: "username") as? String
                       
                        if userNameData == userName
                        {
                            return false
                        }
                }
        }
        catch{return false}
        return true
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if txtPass.text! == "" || txtUserName.text! == "" || txtname.text! == "" || txtEmail.text! == "" || conPass.text! == ""
        {
                let alert = UIAlertController(title: "Login", message: "Please enter values", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        else{
            let val=getData(userName: txtUserName.text!)
            
            if(val==true)
            {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Login", in: context)
                let newEntity = NSManagedObject(entity: entity!, insertInto:context)
                
                if getData(userName: txtUserName.text!)
                {
                    if txtPass.text! == conPass.text!
                    {
                        newEntity.setValue(txtUserName.text, forKey: "username")
                        newEntity.setValue(txtname.text, forKey: "name")
                        newEntity.setValue(txtEmail.text, forKey: "email")
                        newEntity.setValue(txtPass.text, forKey: "password")
                       
                        do{
                            try context.save()
                        }
                        catch{}
                        
                        let alert = UIAlertController(title: "Alert", message: "Signed In. Proceed to Login.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Alert", message: "Password and Confrim PAssword do not match", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    
                    }
                }
            }
            else{

                let alert = UIAlertController(title: "Alert", message: "Username already Exists!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 view.endEditing(true)
                 super.touchesBegan(touches, with: event)
             }
    
}
