//
//  ListCampaignByMerchantTableViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/4/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit
import CoreData

class ListCampaignByMerchantTableViewController: UITableViewController {
    
    let coreDataStack: CoreDataStack = CoreDataStack()
    var campaignList: [Campaign] = []
    var fetchRequest: NSFetchRequest<Campaign>!

    var merchant: Merchant!

    let coreAPI: CoreAPI = CoreAPI()
    var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
         // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        loadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadData() {
        //
        fetchRequest = Campaign.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "byMerchant == %d", merchant.id)
        do {
           let count = try coreDataStack.managedObjectContext.count(for: fetchRequest)
            if count == 0 {
                print("--- IMPORT CAMPAIGN BY MERCHANT ---")
                loadingIndicatorView(message: "loading ... ")
                
                var APIInfo: [String: Any] = [String: Any]()
                APIInfo["ID"] = merchant.id
                APIInfo["nameAPI"] = "listCampaignByMerchant"
                APIInfo["httpMethod"] = "GET"
                APIInfo["urlAPI"] = "/campaign/?merchantId=\(merchant.id)"
                APIInfo["headerAPI"] = nil
                APIInfo["paramBody"] = nil
                
                coreAPI.requestAPI(APIInfo, saveData: true, sendData: false, completionData: { (response, data) in
                    DispatchQueue.main.async {
                        if response.first! == "noconnection" {
                            let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
                            self.present(noConnectionView, animated: true, completion: nil)
                        }else{
                            self.alertViewWithMessage(response.first!, "OK")
                        }
                    }
                }) {
                    DispatchQueue.main.async {
                        self.loadingView.removeFromSuperview()
                        do {
                            let results = try self.coreDataStack.managedObjectContext.fetch(self.fetchRequest)
                            self.campaignList = results
                            self.tableView.reloadData()
                        } catch  {
                            fatalError("Error: \(error)")
                        }
                    }
                }
            }else {
                do {
                    let results = try coreDataStack.managedObjectContext.fetch(fetchRequest)
                    campaignList = results
                    tableView.reloadData()
                } catch  {
                    fatalError("Error: \(error)")
                }
            }
        } catch let error as NSError {
            fatalError("Error: \(error)")
        }
    }
    
    func loadingIndicatorView(message: String) {
        loadingView = UIView(frame: CGRect(origin: CGPoint(x: 30, y: self.view.frame.size.height/2 - 25), size: CGSize(width: self.view.frame.width - 60, height: 50)))
        loadingView.backgroundColor = UIColor.white
        
        let indicatorView = LifePlusActivityIndicator(image: UIImage.init(named: "activity_indicator")!, frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 50, height: 50)))
        let messageLabel = UILabel(frame: CGRect(origin: CGPoint(x: 60,y: 0), size: CGSize(width: loadingView.frame.size.width - 60, height: 50)))
        indicatorView.startAnimating()
        messageLabel.text = message
        messageLabel.textAlignment = NSTextAlignment.left
        loadingView.addSubview(indicatorView)
        loadingView.addSubview(messageLabel)
        loadingView.layer.cornerRadius = 5.0
        loadingView.clipsToBounds = true
        // loadingView.layer.borderColor = UIColor.greenLifePlus.cgColor
        //loadingView.layer.borderWidth = 0.5
        self.view.addSubview(loadingView)
        
    }
    
    private func alertViewWithMessage(_ message: String,_ buttonTitle: String ) {
        
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lifePlusAlertView") as! LifePlusAlertViewController
        alertView.message = message
        alertView.buttonTitle = buttonTitle
        self.addChildViewController(alertView)
        alertView.view.frame = self.view.frame
        self.view.addSubview(alertView.view)
        alertView.didMove(toParentViewController: self)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return campaignList.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            tableView.register(UINib.init(nibName: "CampaignByMerchantTableViewCell1", bundle: nil), forCellReuseIdentifier: "Cell1")
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! CampaignByMerchantTableViewCell1
            
            cell1.merchantImageView.image = try! UIImage(data: Data(contentsOf: URL(string: merchant.merchantLogo!)!))
            cell1.merchantName.text = merchant.merchantName
            cell1.merchantOpen.text = merchant.open
            cell1.merchantClose.text = merchant.close
            cell1.merchantAddress.text = merchant.address
            cell1.merchantHotline.text = merchant.phone
            cell1.merchantWebsite.text = merchant.website
            cell1.closeButton .addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
            return cell1
        }else{
            tableView.register(UINib.init(nibName: "CampaignByMerchantTableViewCell2", bundle: nil), forCellReuseIdentifier: "Cell2")
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! CampaignByMerchantTableViewCell2
            
            let currentCampaign: Campaign = campaignList[indexPath.row]
            cell2.campaignImageView.image = try! UIImage(data: Data(contentsOf: URL(string: currentCampaign.bannerCampaign!)!))
            cell2.campaignNameLabel.text = currentCampaign.nameCampaign
            return cell2
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 558
        }else {
            return 250
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if  section == 1 {
            return "ƯU ĐÃI ĐANG TÀI TRỢ"
        }
        return ""
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let couponInfoView = self.storyboard?.instantiateViewController(withIdentifier: "couponInfoVC") as! CouponInfoViewController
            couponInfoView.currentCampaign = campaignList[indexPath.row]
            couponInfoView.currentMerchant = merchant
            self.navigationController?.pushViewController(couponInfoView, animated: true)
        }
    }
    
   @objc func handleCloseButton() {
       let _ = self.navigationController?.popViewController(animated: true)
    }

}
