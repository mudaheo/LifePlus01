//
//  DetailCampaignViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class DetailCampaignViewController: UIViewController {

    @IBOutlet weak var campaignImageView: UIImageView!
    @IBOutlet weak var dayCountDownLabel: UILabel!
    @IBOutlet weak var timeCountDownLabel: UILabel!
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var merchantOpenLabel: UILabel!
    @IBOutlet weak var merchantCloseLabel: UILabel!
    @IBOutlet weak var brandAddressLabel: UILabel!
    @IBOutlet weak var merchantImageView: UIImageView!
    @IBOutlet weak var listLocationButton: UIButton!
    @IBOutlet weak var registerCloseCustomerButton: UIImageView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("2")
        
    }
    func setupUI() {
        listLocationButton.layer.cornerRadius = listLocationButton.frame.size.height/2
        listLocationButton.clipsToBounds = true
        listLocationButton.layer.borderColor = UIColor.greenLifePlus.cgColor
        listLocationButton.layer.borderWidth = 1
        
    }
    func handleGetCouponButton() {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Action
    
    @IBAction func handleListLocationButton(_ sender: Any) {
    }

    @IBOutlet weak var handleRegisterCloseCustomerButton: UIImageView!
}
