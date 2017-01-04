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
    var loadingView: UIView!
    
    let coreAPI: CoreAPI = CoreAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        tickImageView.layer.cornerRadius = tickImageView.frame.size.width/2
        tickImageView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadingIndicatorView(message: String) {
        loadingView = UIView(frame: CGRect(origin: CGPoint(x: 30, y: self.view.frame.size.height/2 - 25), size: CGSize(width: self.view.frame.width - 60, height: 50)))
        loadingView.backgroundColor = UIColor.white
        
        let indicatorView = LifePlusActivityIndicator(image: UIImage.init(named: "activity_indicator")!, frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 50, height: 50)))
        let messageLabel = UILabel(frame: CGRect(origin: CGPoint(x: 60,y: 0), size: CGSize(width: loadingView.frame.size.width - 60, height: 50)))
        indicatorView.startAnimating()
        messageLabel.text = message
        messageLabel.textAlignment = NSTextAlignment.left
        loadingView.addSubview(indicatorView)
        loadingView.addSubview(messageLabel)
        loadingView.layer.cornerRadius = 5.0
        loadingView.clipsToBounds = true
       // loadingView.layer.borderColor = UIColor.greenLifePlus.cgColor
        //loadingView.layer.borderWidth = 0.5
        self.view.addSubview(loadingView)
    
    }
    
    //MARK: - Action
    

    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
  
    @IBAction func handleSignUpButton(_ sender: Any) {
        loadingIndicatorView(message: "Loading ...")
        
        var APIInfo: [String: Any] = [String: Any]()
        APIInfo["nameAPI"] = "signupUser"
        APIInfo["httpMethod"] = "POST"
        APIInfo["urlAPI"] = "/merchant/2/signup"
        APIInfo["headerAPI"] = nil
        APIInfo["paramBody"] = [
            "Email":"\(emailUserTextField.text!)",
            "Password":"\(passwordUserTextField.text!)",
            "Phone":"\(phoneUserTextField.text!)",
            "Info":[[
                "FieldTable": "gender",
                "Value" :"male"
                ]]
        ]
        
        coreAPI.requestAPI(APIInfo,saveData: false,sendData: false, completionData: { (response, data) in
            DispatchQueue.main.async {
            if response.first! == "noconnection" {
                    let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
                    self.present(noConnectionView, animated: true, completion: nil)
                }else{
                    if self.phoneUserTextField.text! == "" || self.emailUserTextField.text! == "" || self.passwordUserTextField.text! == "" {
                        let message: String = "Hãy điền đầy đủ thông tin"
                        self.alertViewWithMessage(message, "OK")
                    }else{
                        if response.first! == "SUCCESS" {
                            
                            let confirmSMSView = self.storyboard?.instantiateViewController(withIdentifier: "confirmSMSVC") as! ConfirmSMSViewController
                            confirmSMSView.currentPhoneNumber = self.phoneUserTextField.text!
                            self.present(confirmSMSView, animated: true, completion: nil)
                        }else{
                            self.alertViewWithMessage(response.first!, "OK")
                        }
                    }
                }
            }

        }) {
            DispatchQueue.main.async {
                self.loadingView.removeFromSuperview()
            }
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
