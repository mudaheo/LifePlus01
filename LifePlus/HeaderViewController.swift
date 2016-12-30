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
        
        campaign.delegate = self
        campaign.getCampaignWithGroupName(groupName: "isFeature=true")
//        scrollView.auk.show(image: UIImage(named: "OT")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension HeaderViewController: CampaignControllerDelegate {
    func getDataWithCampaignFromAPI(dataArr: Array<Any>) {
        getData(dataArr: dataArr)
        DispatchQueue.main.async {
            for item in self.imageArr {
                self.scrollView.auk.show(url: item)
                self.scrollView.auk.startAutoScroll(delaySeconds: 3.0)
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
}

extension HeaderViewController: UIScrollViewDelegate {
    
}
