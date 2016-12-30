//
//  ConfirmSMSViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/27/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class ConfirmSMSViewController: UIViewController {
    @IBOutlet weak var activatedCodeTextField: UITextField!
    var currentPhoneNumber: String!
    let confirmSMS: ConfirmSMSAPI = ConfirmSMSAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Action
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleConfirmButton(_ sender: Any) {
      confirmSMS.requestActivateUser(activatedCodeTextField.text!) { (response) in
        DispatchQueue.main.async {
            if response.first == "noconnection" {
                
            }else{
                if response.first == "success" {
                    let chooseBrandView = self.storyboard?.instantiateViewController(withIdentifier: "ChooseBrandVC") as! ChooseBrandViewController
                    self.present(chooseBrandView, animated: true, completion: nil)
                }else {
                    self.alertViewWithMessage(response.first!, "OK")
                }
            }
        }
    }
}
    @IBAction func handleResendSMSButton(_ sender: Any) {
        confirmSMS.requestResendSMS(currentPhoneNumber) { (response) in
            DispatchQueue.main.async {
                if response.first == "noconnection" {
                    
                }else{
                    if response.first == "success" {
                        self.alertViewWithMessage(response[1], "OK")
                    }else{
                        self.alertViewWithMessage(response.first!, "OK")
                    }
                }
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


}
