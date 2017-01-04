//
//  ConfirmSignUpViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/27/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class ConfirmSignUpViewController: UIViewController {
    
    var currentMerchant: Merchant!

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInfo()
    }
    
    func loadInfo() {
        tickImage.layer.cornerRadius = tickImage.frame.width/2
        tickImage.clipsToBounds = true
        tickImage.alpha = 0.9
        
        brandImage.image = try! UIImage(data: Data(contentsOf: URL(string: currentMerchant.merchantLogo!)!))
        brandImage.layer.cornerRadius = brandImage.frame.width/2
        brandImage.clipsToBounds = true
        brandImage.layer.borderColor = UIColor.black.cgColor
        brandImage.layer.borderWidth = 0.5
        brandNameLabel.text = currentMerchant.merchantName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Action
    

}
