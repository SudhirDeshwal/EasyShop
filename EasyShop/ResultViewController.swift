//
//  ResultViewController.swift
//  EasyShop
//
//  Created by user165333 on 8/12/20.
//  Copyright © 2020 EasyShop. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var billitemArrayResult : [BillItem]?
    var Total : Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for p in billitemArrayResult! {
            
            let frame = CGRect(x: 132, y: 220, width: 25, height: 21)
            let label = UILabel(frame: frame)
            Total = Total! + (Double(Double(p.itemQantity!) * Double(p.price!)))
            label.text = ("\(p.itemName)+\(self.Total)")
            
            
            
            view.addSubview(label)
            
            
            
        }
        
    }
    
     
    @IBOutlet weak var myabel: UILabel!
    

}
