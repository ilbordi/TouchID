//
//  ViewController.swift
//  TouchID
//
//  Created by Francesco Bordignon on 12/08/15.
//  Copyright © 2015 Francesco Bordignon. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
  
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.touchID()

    }

    func touchID(){
        
        let context = LAContext()
        var errore:NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &errore){
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Sblocca", reply: { (successo, errore1) -> Void in
                
                if errore1 == nil{
                    
                    self.performSegueWithIdentifier("showSVC", sender: self)
                }else{
                    
                    switch errore1!.code{
                        
                    case LAError.SystemCancel.rawValue:
                        self.dismissViewControllerAnimated(true, completion: nil)
                    case LAError.UserCancel.rawValue:
                        self.dismissViewControllerAnimated(true, completion: nil)
                    case LAError.UserFallback.rawValue:
                        self.dismissViewControllerAnimated(true, completion: nil)
                    default:
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            })
        }
    }

}
extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == passwordTextField{
            
            self.performSegueWithIdentifier("showSVC", sender: self)
            return true
        }else{
            
            return false
        }
    }
}
