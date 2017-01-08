//
//  BranchMapTableViewCell.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/8/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class BranchMapTableViewCell: UITableViewCell {

    @IBOutlet weak var branchAddressLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
