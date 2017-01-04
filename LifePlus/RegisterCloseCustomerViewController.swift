//
//  RegisterCloseCustomerViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/27/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class RegisterCloseCustomerViewController: UIViewController {

    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandNameLable: UILabel!
    @IBOutlet weak var couponCountLabel: UILabel!
    @IBOutlet weak var giftCountLable: UILabel!
    @IBOutlet weak var customerCountLabel: UILabel!
    @IBOutlet weak var nameCustomerTextField: UITextField!
    
    //let codeDataStack: CoreDataStack = CoreDataStack()
    var currentMerchant: Merchant!


    var merchantIndex: Int!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()

    }
    func loadInfo() {
        brandImage.image = try! UIImage(data: Data(contentsOf: URL(string: currentMerchant.merchantLogo!)!))
        brandImage.layer.cornerRadius = brandImage.frame.size.width/2
        brandImage.clipsToBounds = true
        brandNameLable.text = currentMerchant.merchantName
        couponCountLabel.text = "\(currentMerchant.totalCampaignCoupon)"
        giftCountLable.text = "\(currentMerchant.totalCompaignGift)"
        customerCountLabel.text = "\(currentMerchant.totalCustomer)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    


    @IBAction func handleRegisterButton(_ sender: Any) {
        let confirmSignUp = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmSignUpVC") as! ConfirmSignUpViewController
        confirmSignUp.currentMerchant = currentMerchant
        self.present(confirmSignUp, animated: true, completion: nil)
    }

    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

