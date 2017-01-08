//
//  MemberMerchantViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/7/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit
import CoreData

class MemberMerchantViewController: UIViewController {
    
    
    let coreDataStack: CoreDataStack = CoreDataStack()
    var merchantList: [Merchant]! = []
    var fetchRequest: NSFetchRequest<Merchant>!
    let color1: String = "00A73D"
    let color2: String = "52C458"
    var loadingView: UIView!

    @IBOutlet weak var merchantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.greenLifePlus

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        loadMerchantData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadMerchantData() {
        fetchRequest = Merchant.fetchRequest()
        do {
            let count = try coreDataStack.managedObjectContext.count(for: fetchRequest)
            if count == 0 {
                print("\n\n -- import Merchant Data -- \n\n")
                loadingIndicatorView(message: "loading ...")
                
                var APIInfo: [String: Any] = [String: Any]()
                APIInfo["nameAPI"] = "merchantList"
                APIInfo["httpMethod"] = "GET"
                APIInfo["urlAPI"] = "/merchant"
                APIInfo["headerAPI"] = nil
                APIInfo["paramBody"] = nil
                
                let coreAPI: CoreAPI = CoreAPI()
                coreAPI.requestAPI(APIInfo, saveData: true, sendData: false, completionData: { (response, data) in
                    DispatchQueue.main.async {
                        if response.first! == "noconnection" {
                            let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
                            self.present(noConnectionView, animated: true, completion: nil)
                        }else{
                            self.alertViewWithMessage(response.first!, "OK")
                        }
                    }
                }){
                    DispatchQueue.main.async {
                        self.loadingView.removeFromSuperview()
                        
                        do {
                            let results = try self.coreDataStack.managedObjectContext.fetch(self.fetchRequest)
                            self.merchantList = results
                            self.merchantTableView.reloadData()
                        } catch  {
                            fatalError("Error: \(error)")
                        }
                    }
                }
                
            }
            else{
                do {
                    let results = try coreDataStack.managedObjectContext.fetch(fetchRequest)
                    merchantList = results
                    merchantTableView.reloadData()
                } catch  {
                    fatalError("Error: \(error)")
                }
            }
        } catch let error as NSError {
            fatalError("Error: \(error)")
        }
        
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

}

extension MemberMerchantViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID: String = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MemberMerchantTableViewCell
        let merchant: Merchant = merchantList[indexPath.row]
        
        cell.nameMerchantLabel.text! = merchant.merchantName!
        cell.addressMerchantLabel.text! = merchant.address!
        cell.couponCountLabel.text = "\(merchant.totalCampaignCoupon)"
        do {
            cell.merchantImageView.image = try UIImage(data: Data(contentsOf: URL(string: merchant.merchantLogo!)!))
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        cell.couponCountLabel.layer.cornerRadius = cell.couponCountLabel.frame.width/2
        cell.couponCountLabel.clipsToBounds = true
        cell.plusLabel.layer.cornerRadius = cell.plusLabel.frame.width/2
        cell.plusLabel.clipsToBounds = true
        cell.merchantImageView.layer.cornerRadius = cell.merchantImageView.frame.width/2
        cell.merchantImageView.clipsToBounds = true
        cell.containView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        if indexPath.row % 2 == 0{
            cell.myView.backgroundColor = UIColor(hex: color1, alpha: 1.0)
        }else{
            cell.myView.backgroundColor = UIColor(hex: color2, alpha: 1.0)
        }
        
        return cell
    }
    
    // DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listCampaignByMerchantView = self.storyboard?.instantiateViewController(withIdentifier: "listCampaignByMerchantVC") as! ListCampaignByMerchantTableViewController
        listCampaignByMerchantView.merchant = merchantList[indexPath.row]
        self.navigationController?.pushViewController(listCampaignByMerchantView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

