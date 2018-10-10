//
//  GenericFunctions.swift
//  GoRN
//
//  Created by Vishnu on 04/09/18.
//  Copyright © 2018 Vishnu. All rights reserved.
//

import UIKit

class GenericFunctions: NSObject {
    
    //MARK:- Alert View Controller
    static  func showAlertView(targetVC: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            
        })))
        targetVC.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Alert View Controller
    static  func showAlertViewWithOptions(targetVC: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SwitchToOtherProfile"), object: nil)
        })))
        alert.addAction((UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in
        })))
        targetVC.present(alert, animated: true, completion: nil)
    }
    
    static  func showAlertViewDismissAutomatically(targetVC: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        targetVC.present(alert, animated: true, completion: nil)
        
        //                DispatchQueue.main.async() { () -> Void in
        //                    dispatch_after(DispatchTime.now(dispatch_time_t(DispatchTime.now()), Int64(2 * Double(NSEC_PER_SEC))), DispatchQueue.main) { () -> Void in
        //                        targetVC.dismissViewControllerAnimated(true, completion: nil)
        //                    }
        //                }
    }
    
    //MARK:- Email Validation
    
    static func isValidEmail(email: String) -> Bool{
        let stricterFilterString:NSString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailRegex:NSString = stricterFilterString
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    static func isOnlyAlphabets(string : String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, (string.count))) != nil {
                return false
            } else {
                return true
            }
        }
        catch {
            return false
        }
    }
    
    static func printMyValue<Anything>(value : Anything){
        print(value)
    }
    
    //MARK: Dymamic Height For Label With Attributed String
    
    static func heightForLabelWithString ( text:String, font:UIFont, width:CGFloat) -> CGSize{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width: width, height:0))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
