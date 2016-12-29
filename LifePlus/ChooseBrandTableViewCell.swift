//
//  ChooseBrandTableViewCell.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/29/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class ChooseBrandTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var nameBrandLabel: UILabel!
    @IBOutlet weak var addressBrandLabel: UILabel!
    @IBOutlet weak var couponBranchLabel: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var plusBrandLabel: UILabel!
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
