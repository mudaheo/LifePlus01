//
//  SignUpAccountViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/27/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import SystemConfiguration

class SignUpAccountViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailUserTextField: UITextField!
    @IBOutlet weak var passwordUserTextField: UITextField!
    @IBOutlet weak var phoneUserTextField: UITextField!
    @IBOutlet weak var tickImageView: UIImageView!
    
    let signUpUser: SignUpUserAPI = SignUpUserAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        tickImageView.layer.cornerRadius = tickImageView.frame.size.width/2
        tickImageView.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action
    

    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
  
    @IBAction func handleSignUpButton(_ sender: Any) {
        signUpUser.requestSignUpUser(2, emailUserTextField.text!, passwordUserTextField.text!, phoneUserTextField.text!, { (responseValue) in
            print("1")
            DispatchQueue.main.async {
                print("2")
                if responseValue.first! == "noconnection" {
                    self.alertViewWithMessage("No Internet", "OK")
                }else{
                    if self.phoneUserTextField.text! == "" || self.emailUserTextField.text! == "" || self.passwordUserTextField.text! == "" {
                        let message: String = "Hãy điền đầy đủ thông tin"
                        self.alertViewWithMessage(message, "OK")
                    }else{
                        if responseValue.first! == "success" {
                            let confirmSMSView = self.storyboard?.instantiateViewController(withIdentifier: "confirmSMSVC") as! ConfirmSMSViewController
                            confirmSMSView.currentPhoneNumber = self.phoneUserTextField.text!
                            self.present(confirmSMSView, animated: true, completion: nil)
                        }else{
                            self.alertViewWithMessage(responseValue.first!, "OK")
                        }
                    }
                }
            }
            
        }){
            print("3")
        }

    }
    
    private func alertViewWithMessage(_ message: String,_ buttonTitle: String ) {
        
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lifePlusAlertView") as! LifePlusAlertViewController
        alertView.message = message
        alertView.buttonTitle = buttonTitle
        self.addChildViewController(alertView)
        alertView.view.frame = self.view.frame
        self.view.addSubview(alertView.view)
        alertView.didMove(toParentViewController: self)
        
    }

    @IBAction func handleLoginNowButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailUserTextField.resignFirstResponder()
        phoneUserTextField.resignFirstResponder()
        passwordUserTextField.resignFirstResponder()
    }


}
