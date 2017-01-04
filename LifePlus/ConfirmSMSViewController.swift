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
    let coreAPI: CoreAPI = CoreAPI()
    var loadingView: UIView!

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
        loadingIndicatorView(message: "loading ...")

        var APIInfo: [String: Any] = [String: Any]()
        APIInfo["nameAPI"] = "activeUser"
        APIInfo["httpMethod"] = "POST"
        APIInfo["urlAPI"] = "/user/activated"
        APIInfo["headerAPI"] = nil
        APIInfo["paramBody"] = ["ActivateCode":"\(activatedCodeTextField.text!)"]
        
        coreAPI.requestAPI(APIInfo,saveData: false,sendData: false, completionData: { (response, data) in
            DispatchQueue.main.async {
                if response.first == "noconnection" {
                    let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
                    self.present(noConnectionView, animated: true, completion: nil)
                }else{
                    if response.first == "SUCCESS" {
                        let chooseBrandView = self.storyboard?.instantiateViewController(withIdentifier: "ChooseBrandVC") as! ChooseBrandViewController
                        self.present(chooseBrandView, animated: true, completion: nil)
                    }else {
                        self.alertViewWithMessage(response.first!, "OK")
                    }
                }
            }
        }) {
            DispatchQueue.main.async {
                self.loadingView.removeFromSuperview()
            }
        }
}
    @IBAction func handleResendSMSButton(_ sender: Any) {
        loadingIndicatorView(message: "loading ...")

        var APIInfo: [String: Any] = [String: Any]()
        APIInfo["nameAPI"] = "resendActivatedCode"
        APIInfo["httpMethod"] = "POST"
        APIInfo["urlAPI"] = "/sms/\(currentPhoneNumber!)/resend"
        APIInfo["headerAPI"] = nil
        APIInfo["paramBody"] = nil
        
        coreAPI.requestAPI(APIInfo,saveData:false,sendData: false, completionData: { (response, data) in
            DispatchQueue.main.async {
                if response.first == "noconnection" {
                    let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
                    self.present(noConnectionView, animated: true, completion: nil)
                }else{
                    if response.first == "SUCCESS" {
                        self.alertViewWithMessage(response[1], "OK")
                    }else{
                        self.alertViewWithMessage(response.first!, "OK")
                    }
                }
            }
        }) {
            DispatchQueue.main.async {
                self.loadingView.removeFromSuperview()
            }
        }
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
