//
//  LoginViewController.swift
//  Curates_table
//
//  Created by Vishnu u on 04/10/18.
//  Copyright © 2018 Vishnu u. All rights reserved.
//

import UIKit
import AFNetworking

class LoginViewController: UIViewController {
    @IBOutlet var btn_Login: UIButton!
    
    @IBOutlet var lbl_pass: UITextField!
    @IBOutlet var lbl_user: UITextField!
    override func viewDidLoad() {
               self.hideKeyboard()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Login(_ sender: Any) {
         AFNetworkReachabilityManager.shared().startMonitoring()
//        if AFNetworkReachabilityManager.shared().isReachable == true {
          if !(lbl_pass.text?.isEmpty)! && !(lbl_user.text?.isEmpty)! {
              let dict1 : NSMutableDictionary = NSMutableDictionary()
            dict1.setValue(lbl_user.text, forKey: "email")
            dict1.setValue(lbl_pass.text, forKey: "password")
            print(dict1)
            let jsonData = try! JSONSerialization.data(withJSONObject: dict1, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)!
//            let dict : NSMutableDictionary = NSMutableDictionary()
            AFNetWorkingServiceManager.sharedManager.parseLinkUsingPostMethod(servicename: "Users/login", parameter: dict1, completion: { (success, result, error) in
                print(success)
                    if success == true {
                        let successVC = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
                        self.navigationController?.pushViewController(successVC, animated: true)
                        
                    }
                    else {
                        GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Something went wrong!")
                        print("Error in Login!!")
                }
        }
        
//    )}
    
)}
          else {
            GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Invalid email id or password.")
            
   
        }
    
   
}
}
