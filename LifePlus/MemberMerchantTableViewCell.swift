//
//  MemberMerchantTableViewCell.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/7/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class MemberMerchantTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var nameMerchantLabel: UILabel!
    @IBOutlet weak var addressMerchantLabel: UILabel!
    @IBOutlet weak var couponCountLabel: UILabel!
    @IBOutlet weak var merchantImageView: UIImageView!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var containView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
