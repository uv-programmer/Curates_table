//
//  RegisterViewController.swift
//  Curates_table
//
//  Created by Vishnu u on 04/10/18.
//  Copyright © 2018 Vishnu u. All rights reserved.
//

import UIKit
import AFNetworking

class RegisterViewController: UIViewController {

    @IBOutlet var lbl_mail: UITextField!
    @IBOutlet var lbl_name: UITextField!
    @IBOutlet var lbl_cnfpassword: UITextField!
    @IBOutlet var lbl_password: UITextField!
    @IBOutlet var btn_register: UIButton!
    override func viewDidLoad() {
        self.hideKeyboard()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn_signup(_ sender: Any) {
//        AFNetworkReachabilityManager.shared().startMonitoring()
//        if AFNetworkReachabilityManager.shared().isReachable == true{
            
        var username = self.lbl_name.text
        var password = self.lbl_password.text
        var email = self.lbl_mail.text
            if !(lbl_mail.text?.isEmpty)! && !(lbl_name.text?.isEmpty)! && !(lbl_password.text?.isEmpty)! && !(lbl_cnfpassword.text?.isEmpty)!{
                if GenericFunctions.isOnlyAlphabets(string: lbl_name.text!)  {
                    if GenericFunctions.isValidEmail(email: lbl_mail.text!){
                        if !((lbl_password.text?.count)! < 8){
                            if lbl_password.text == lbl_cnfpassword.text{
                                let dict : NSMutableDictionary = NSMutableDictionary()
                                  dict.setValue(lbl_mail.text, forKey: "email")
                                  dict.setValue(lbl_name.text, forKey: "name")
                                  dict.setValue(lbl_password.text, forKey: "password")
                                print(dict)
                                AFNetWorkingServiceManager.sharedManager.parseLinkUsingPostMethod(servicename: "Users", parameter: dict, completion: { (success, result, error) in
                                    if success == true {

                                let successVC = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
                                    self.navigationController?.pushViewController(successVC, animated: true)
                                        
                                    }
                                    else {
                                        self.lbl_name.text = ""
                                        self.lbl_mail.text = ""
                                        self.lbl_password.text = ""
                                        self.lbl_cnfpassword.text = ""
                                        GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Invalid email id or password.")
                                    }
                            }
                      
                )}
                            else{
                                GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Passwords do not match.")
                            }
            }
                        else{
                            GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Passwords must have a minimum of 8 characters.")
                        }
      
    }
                    else{
                        GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: " Enter a valid Email ID")
                    }
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
            else{
                GenericFunctions.showAlertView(targetVC: self, title: "Drona", message: "Kindly fill all the fields.")
        }
//}
    }}
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
