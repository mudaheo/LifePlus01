//
//  CouponInfoViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class CouponInfoViewController: UIViewController {
    
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    
    var currentCampaign: Campaign!
    var currentMerchant: Merchant!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //containerView.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: self.view.frame.width, height: containerView.frame.height))
        //myScrollView.addSubview(containerView)
        //myScrollView.contentSize.height = containerView.frame.size.height
        setupUI()
        print("1")

    }
    func setupUI() {
        let getCouponButton: UIButton = UIButton(frame: CGRect(origin: CGPoint(x: 30,y: self.view.frame.height - 80 ), size: CGSize(width: self.view.frame.width - 60, height: 50)))
        getCouponButton.setImage(UIImage.init(named: "getCoupon"), for: .normal)
        
        self.view.addSubview(getCouponButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailCampaign" {
            let detailCampaignView = segue.destination as! DetailCampaignViewController
            detailCampaignView.currentCampaign = currentCampaign
            detailCampaignView.currentMerchant = currentMerchant
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
