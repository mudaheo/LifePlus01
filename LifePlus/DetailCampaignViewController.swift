//
//  DetailCampaignViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit
import CoreData

class DetailCampaignViewController: UIViewController {

    @IBOutlet weak var campaignImageView: UIImageView!
    @IBOutlet weak var dayCountDownLabel: UILabel!
    @IBOutlet weak var timeCountDownLabel: UILabel!
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var merchantOpenLabel: UILabel!
    @IBOutlet weak var merchantCloseLabel: UILabel!
    @IBOutlet weak var brandAddressLabel: UILabel!
    @IBOutlet weak var merchantImageView: UIImageView!
    @IBOutlet weak var listLocationButton: UIButton!
    @IBOutlet weak var registerCloseCustomerButton: UIImageView!
    
    var currentMerchant: Merchant!
    
    let coreDataStack: CoreDataStack = CoreDataStack()
    var campaignList: [Campaign] = []
    var fetchRequest: NSFetchRequest<Campaign>!
    var currentCampaign: Campaign!
    var detailCampaign: Campaign = Campaign()
    let coreAPI: CoreAPI = CoreAPI()
    
    var branchList: Set<Branch> = Set<Branch>()
    var currentBranch: Branch!
    
    
    var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("2")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func setupUI() {
        listLocationButton.layer.cornerRadius = listLocationButton.frame.size.height/2
        listLocationButton.clipsToBounds = true
        listLocationButton.layer.borderColor = UIColor.greenLifePlus.cgColor
        listLocationButton.layer.borderWidth = 1
        merchantImageView.layer.cornerRadius = merchantImageView.frame.width/2
        merchantImageView.clipsToBounds = true
        merchantImageView.layer.borderColor = UIColor.lightGray.cgColor
        merchantImageView.layer.borderWidth = 1.0
        
    }
    
    func loadDataToUI() {
        do {
            campaignImageView.image = try UIImage(data: Data(contentsOf: URL(string: detailCampaign.bannerCampaign!)!))
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        brandAddressLabel.text = currentBranch.addressBranch
        do {
            merchantImageView.image = try UIImage(data: Data(contentsOf: URL(string: currentMerchant.merchantLogo!)!))
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadData() {
        //
        fetchRequest = Campaign.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "iDCampaign == %d", currentCampaign.iDCampaign)
  //      do {
//            let count = try coreDataStack.managedObjectContext.count(for: fetchRequest)
//            if count == 0 {
                print("--- UPDATE DETAIL CAMPAIGN ---")
                loadingIndicatorView(message: "loading ... ")
                
                var APIInfo: [String: Any] = [String: Any]()
                APIInfo["ID"] = currentCampaign.iDCampaign
                APIInfo["nameAPI"] = "detailCampaign"
                APIInfo["httpMethod"] = "GET"
                APIInfo["urlAPI"] = "/campaign/\(currentCampaign.iDCampaign)"
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
                        print("Load OK")
                                                do {
                                                    let results = try self.coreDataStack.managedObjectContext.fetch(self.fetchRequest)
                                                    self.campaignList = results
                                                    self.detailCampaign = self.campaignList.first!
                                                    self.branchList = self.detailCampaign.branchs as! Set<Branch>
                                                    print(self.detailCampaign.branchs?.count ?? "Non Branch")
                                                    self.currentBranch = self.branchList.first!
                                                    self.loadDataToUI()
                                                } catch  {
                                                    fatalError("Error: \(error)")
                                                }
                    }
                }
//            }else {
//                do {
//                    let results = try coreDataStack.managedObjectContext.fetch(fetchRequest)
//                    campaignList = results
//                    detailCampaign = campaignList.first!
//                    loadDataToUI()
//                } catch  {
//                    fatalError("Error: \(error)")
//                }
//            }
//        } catch let error as NSError {
//            fatalError("Error: \(error)")
//        }
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
    func handleGetCouponButton() {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

    //MARK: - Action
    
    @IBAction func handleListLocationButton(_ sender: Any) {
        let branchMapView = self.storyboard?.instantiateViewController(withIdentifier: "branchMapVC") as! BranchMapViewController
        let branchArray = Array(branchList)
        branchMapView.currentMerchant = currentMerchant
        branchMapView.branchList = branchArray
        self.navigationController?.pushViewController(branchMapView, animated: true)
    }

    @IBOutlet weak var handleRegisterCloseCustomerButton: UIImageView!
}
