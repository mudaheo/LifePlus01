//
//  CustomCell.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var imvItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imvMerchant: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codePRIN
        imvMerchant.layer.cornerRadius = imvMerchant.frame.width / 2
        imvMerchant.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
