//
//  ForgotPasswordViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 28/05/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    
    var emailConfirmationTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        view.addGestureRecognizer(tapGesture)
        emailTextField.delegate = self
        
        
    }
    
    @objc func didTap(gesture:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func changePasswordButton(_ sender: Any) {
        emailTextField.resignFirstResponder()
        if (emailTextField.text?.isEmpty)! {
            self.view.makeToast(ServerRequestConstants.resultErrors.emptyText, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        
        if (emailTextField.text?.contains("@"))! == false && emailTextField.text?.contains(".") == false{
            self.view.makeToast(ServerRequestConstants.resultErrors.invalidEmail, duration: 3.0, position:.bottom, title: "Error") { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
            return
        }
        var params = Dictionary<String, String>();
        params["request"] = "0"
        params["mail"] = emailTextField.text
        ServerRequestManager.instance.forgotPostRequest(params: params as Dictionary<NSString, NSString>, url: ServerRequestConstants.URLS.FORGOT_PASSWORD_URL, postCompleted: { (response, msg, json) -> () in
            
           print(response)
            print(msg)
            self.createAlert(msg: msg)
            
            
        })
        
        
    }
    
    func emailConfirmationTextField(textField: UITextField!) {
        emailConfirmationTextField = textField
        emailConfirmationTextField?.placeholder = "Validation Code"
    }
    
    func okHandler(alert: UIAlertAction) {
        
        
    }
    
    func createAlert(msg: String?){
        let alertController = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: emailConfirmationTextField)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: self.okHandler)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
