//
//  CampaignByMerchantTableViewCell1.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/4/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class CampaignByMerchantTableViewCell1: UITableViewCell {
    @IBOutlet weak var merchantImageView: UIImageView!
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantOpen: UILabel!
    @IBOutlet weak var merchantClose: UILabel!
    @IBOutlet weak var merchantHotline: UILabel!
    @IBOutlet weak var merchantWebsite: UILabel!
    @IBOutlet weak var merchantAddress: UILabel!
    
    @IBOutlet weak var getListLocationButton: UIButton!
    @IBOutlet weak var tickButton: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tickButton.layer.cornerRadius = tickButton.frame.width/2
        tickButton.clipsToBounds = true
        
        getListLocationButton.layer.cornerRadius = getListLocationButton.frame.height/2
        getListLocationButton.clipsToBounds = true
        getListLocationButton.layer.borderColor = UIColor.greenLifePlus.cgColor
        getListLocationButton.layer.borderWidth = 1.0
        merchantImageView.layer.cornerRadius = merchantImageView.frame.width/2
        merchantImageView.clipsToBounds = true
        merchantImageView.layer.borderColor = UIColor.lightGray.cgColor
        merchantImageView.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func handleListLocation(_ sender: Any) {
        
    }
    
}
