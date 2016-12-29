//
//  LifePlusAlertViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/29/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class LifePlusAlertViewController: UIViewController {
    @IBOutlet weak var contentAlertLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var mainAlertView: UIView!
    
    var message: String!
    var buttonTitle: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        mainAlertView.layer.cornerRadius = 10
        mainAlertView.clipsToBounds = true
        
        contentAlertLabel.text = message
        alertButton.setTitle(buttonTitle, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func handleAlertButton(_ sender: Any) {
        self.view.removeFromSuperview()
    }

}
