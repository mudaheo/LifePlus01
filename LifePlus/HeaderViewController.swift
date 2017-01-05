//
//  HeaderViewController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import Auk

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageArr = [String]()
    var campaign = CampaignController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        campaign.getCampaignWithGroupName(groupName: "isFeature=true") { (dataArr) in
            self.getData(dataArr: dataArr)
            DispatchQueue.main.async {
                self.scrollView.auk.startAutoScroll(delaySeconds: 3.0)
                self.scrollView.auk.settings.contentMode = .scaleToFill
                self.scrollView.auk.settings.pageControl.cornerRadius = 0.0
//                self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 10)
                for item in self.imageArr {
                    self.scrollView.auk.show(url: item)
                }
            }
        }
    }
    
    
    func getData(dataArr: Array<Any>) {
        if imageArr.count == 0 {
            for item in dataArr{
                let item = item as! Dictionary<String, Any>
                let link = item["Banner"]
                self.imageArr.append(link as! String)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
