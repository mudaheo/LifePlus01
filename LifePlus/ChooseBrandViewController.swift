//
//  ChooseBrandViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/26/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import CoreData

class ChooseBrandViewController: UIViewController {
    let coreDataStack: CoreDataStack = CoreDataStack()
    var merchantList: [Merchant]! = []
    var fetchRequest: NSFetchRequest<Merchant>!
    let color1: String = "00A73D"
    let color2: String = "52C458"
    var loadingView: UIView!
    
    
    
    @IBOutlet weak var merchantTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        importDataIfNeed()

    }
    
    func importDataIfNeed() {
        fetchRequest = Merchant.fetchRequest()
        do {
            let count = try coreDataStack.managedObjectContext.count(for: fetchRequest)
            if count == 0 {
                print("\n\n -- import Data -- \n\n")
                loadingIndicatorView(message: "loading ...")
//                let merchantListAPI: MerchantListAPI = MerchantListAPI()
//                merchantListAPI.requestMerchantList({ (response) in
//                    DispatchQueue.main.async {
//                        if response.first! == "noconnection" {
//                            let noConnectionView = self.storyboard?.instantiateViewController(withIdentifier: "noConnectionVC") as! NoConnectionViewController
//                            self.present(noConnectionView, animated: true, completion: nil)
//                        }else{
//                            self.alertViewWithMessage(response.first!, "OK")
//                        }
//                    }
//                })
                
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        //
    }

}
extension ChooseBrandViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID: String = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ChooseBrandTableViewCell
        let merchant: Merchant = merchantList[indexPath.row]
        
        cell.nameBrandLabel.text! = merchant.merchantName!
        cell.addressBrandLabel.text! = merchant.address!
        cell.couponBranchLabel.text = "\(merchant.totalCampaignCoupon)"
        do {
            cell.brandImageView.image = try UIImage(data: Data(contentsOf: URL(string: merchant.merchantLogo!)!))
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        cell.couponBranchLabel.layer.cornerRadius = cell.couponBranchLabel.frame.width/2
        cell.couponBranchLabel.clipsToBounds = true
        cell.plusBrandLabel.layer.cornerRadius = cell.plusBrandLabel.frame.width/2
        cell.plusBrandLabel.clipsToBounds = true
        cell.brandImageView.layer.cornerRadius = cell.brandImageView.frame.width/2
        cell.brandImageView.clipsToBounds = true
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
        let registerCloseCustomer = self.storyboard?.instantiateViewController(withIdentifier: "RegisterCloseCustomerVC") as! RegisterCloseCustomerViewController
        let merchant: Merchant = merchantList[indexPath.row]
        registerCloseCustomer.merchantIndex = indexPath.row
        registerCloseCustomer.currentMerchant = merchant
        self.present(registerCloseCustomer, animated: true, completion: nil)
    }
}


