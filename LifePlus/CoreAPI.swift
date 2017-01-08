//
//  CoreAPI.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/27/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import CoreData

class CoreAPI: NSObject {
    
    // Save Data
    let coreDataStack: CoreDataStack = CoreDataStack()
    var managedContext: NSManagedObjectContext!
    var currentMerchant: Merchant!
    var campaignByMerchant: Campaign!
    var currentBranch: Branch!
    
    let baseURL: String = "https://api.lifeplusloyalty.vn"
    let myData: Data = Data()
    // load Data
    var fetchCampaignRequest: NSFetchRequest<Campaign>!
    
    
    /*
     // APIInfo template
     
     var APIInfo: [String: Any] = [String: Any]()
     APIInfo["nameAPI"] = "merchantList"
     APIInfo["httpMethod"] = "POST"
     APIInfo["urlAPI"] = "/merchant/2/signup"
     APIInfo["headerAPI"] = nil
     APIInfo["paramBody"] = [
     "Email":"\(emailUserTextField.text!)",
     "Password":"\(passwordUserTextField.text!)",
     "Phone":"\(phoneUserTextField.text!)",
     "Info":[[
     "FieldTable": "gender",
     "Value" :"male"
     ]]
     ]
     
     */
    
    func requestAPI(_ APIInfo: [String: Any],saveData: Bool,sendData: Bool,completionData: @escaping ([String], Data) -> (),completionIndicator: @escaping() -> ()) {
        //check connection
        if currentReachabilityStatus != .notReachable {
            //create request
            let request: NSMutableURLRequest = NSMutableURLRequest()
            request.httpMethod = APIInfo["httpMethod"] as! String
            request.url = URL(string: baseURL + (APIInfo["urlAPI"] as! String))
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if APIInfo["headerAPI"] != nil {
                for item in APIInfo["headerAPI"] as! [String: String] {
                    request.addValue(item.value, forHTTPHeaderField: item.key)
                }
            }
            if APIInfo["paramBody"] != nil {
                let dataBody = try! JSONSerialization.data(withJSONObject: (APIInfo["paramBody"] as! [String: Any]), options: .prettyPrinted)
                
                let json = NSString(data: dataBody, encoding: String.Encoding.utf8.rawValue)
                if let json = json {
                    print(json)
                }
                request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
            }

            
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            let urlSeason: URLSession = URLSession(configuration: config)
            let task = urlSeason.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if !(error != nil) {
                    if data != nil {
                
                        var statusCode: Int = 0
                        if let httpRespose: HTTPURLResponse = response as? HTTPURLResponse {
                            statusCode = httpRespose.statusCode
                        }
                        // check Status code
                        if statusCode == 200 {
                            if sendData {
                                    completionData(["SUCCESS"],data!)
                            }else if saveData {
                                self.managedContext = self.coreDataStack.managedObjectContext
                                
                                switch APIInfo["nameAPI"] as! String{
                                case "merchantList":
                                    self.parseMerchantListJSON(data!)
                                    break
                                case "listCampaignByMerchant":
                                    let id: Int32 = APIInfo["ID"] as! Int32
                                    self.parseListCampaignByMerchant(data!,id)
                                    break
                                case "detailCampaign":
                                    let id: Int32 = APIInfo["ID"] as! Int32
                                    self.parseDetailCampaign(data!,id)
                                    break
                                default:
                                    print("Non - Value")
                                    break
                                }
                            }else {
                                
                                let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                                if (parsedData?["Message"] != nil){
                                    completionData(["SUCCESS",parsedData?["Message"] as! String],data!)
                                }
                            }
                            
                        }else{
                            var messageArr: [String] = [String]()
                            let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            if (parsedData?["Fields"] != nil) {
                                for message in parsedData!["Fields"] as! [[String: String]]{
                                    messageArr.append(message["Message"]!)
                                }
                                
                                    completionData(messageArr,data!)
                            }else{
                                if (parsedData?["Message"] != nil){
                                    
                                    completionData([parsedData?["Message"] as! String],data!)
                                }else{
                                    if (parsedData?["Status"] != nil){
                                        //callBackResponse([parsedData?["Status"] as! String])
                                        completionData([parsedData?["Status"] as! String], data!)
                                    }
                                }
                            }
                        }
                    }
                }
                completionIndicator()
            })
            task.resume()
        }else{
            // No Connection
            completionIndicator()
            completionData(["noconnection"],myData)
        }
    }
    
    //MARK: - Parse JSON
    
    //Merchant List
    private func parseMerchantListJSON(_ data: Data) {
        let dataJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        if dataJSON?["Data"] != nil {
            for item in dataJSON?["Data"] as! [[String: Any]] {
                
                //let merchantItem: Merchant = Merchant()
                let merchantEntity = NSEntityDescription.entity(forEntityName: "Merchant", in: managedContext)
                currentMerchant = Merchant(entity: merchantEntity!, insertInto: managedContext)
                
                for item1 in item {
                    switch item1.key {
                    case "Id":
                        currentMerchant.id = item1.value as! Int32
                    case "MerchantName":
                        currentMerchant.merchantName = (item1.value as! String)
                    case "MerchantLogo":
                        currentMerchant.merchantLogo = (item1.value as! String)
                    case "Address":
                        currentMerchant.address = (item1.value as! String)
                    case "TotalCampaignCoupon":
                        currentMerchant.totalCampaignCoupon = item1.value as! Int32
                    case "TotalCampaignGift":
                        currentMerchant.totalCompaignGift = item1.value as! Int32
                    case "TotalCustomer":
                        currentMerchant.totalCustomer = item1.value as! Int32
                    case "Open":
                        currentMerchant.open = (item1.value as! String)
                    case "Close":
                        currentMerchant.close = (item1.value as! String)
                    case "Phone":
                        currentMerchant.phone = (item1.value as! String)
                    case "Website":
                        currentMerchant.website = (item1.value as! String)
                    default:
                        break
                    }
                }
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
        }
    }
    
    //List Campaign By Merchant
    private func parseListCampaignByMerchant(_ data: Data,_ id: Int32) {
        let dataJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        if dataJSON?["Data"] != nil {
            for item in dataJSON?["Data"] as! [[String: Any]] {
                let campaignEntity = NSEntityDescription.entity(forEntityName: "Campaign", in: managedContext)
                campaignByMerchant = Campaign(entity: campaignEntity!, insertInto: managedContext)
                campaignByMerchant.byMerchant = id
                
                for item1 in item {
                    switch item1.key {
                    case "Id":
                        campaignByMerchant.iDCampaign = item1.value as! Int32
                    case "Name":
                        campaignByMerchant.nameCampaign = (item1.value as! String)
                    case "Description":
                        campaignByMerchant.descriptionCampaign = (item1.value as! String)
                    case "CreatedAt":
                        campaignByMerchant.createAtCampaign = (item1.value as! String)
                    case "StartDate":
                        campaignByMerchant.startDateCampaign = (item1.value as! String)
                    case "EndDate":
                        campaignByMerchant.endDateCampaign = (item1.value as! String)
                    case "Banner":
                        campaignByMerchant.bannerCampaign = (item1.value as! String)
                    case "TypeCampaign":
                        campaignByMerchant.typeCampaign = (item1.value as! String)
                    case "GroupCampaign":
                        campaignByMerchant.groupCampaign = (item1.value as! String)
                    case "Distance":
                        campaignByMerchant.distanceCampaign = item1.value as! Double
                    case "TotalPointCampaign":
                        campaignByMerchant.totalPointCampaign = item1.value as! Int32
                    case "IsLogin":
                        campaignByMerchant.isLoginCampaign = item1.value as! Bool
                    case "HasSurvey":
                        campaignByMerchant.hasSurvey = item1.value as! Bool
                    case "ReceiveCampaign":
                        campaignByMerchant.receiveCampaign = (item1.value as! String)
                    case "IsReceive":
                        campaignByMerchant.isReceiveCampaign = item1.value as! Bool
                    default:
                        
                        break
                    }
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
        }
    }
    
    private func parseDetailCampaign(_ data: Data,_ id: Int32) {
        print("parse Detail Campaign")
        fetchCampaignRequest = Campaign.fetchRequest()
        var updateCampaign: Campaign = Campaign()
        
        print("Item ID")
        let idPredicate: NSPredicate = NSPredicate.init(format: "iDCampaign == %d", id)
        fetchCampaignRequest.predicate = idPredicate
        do {
            let results = try coreDataStack.managedObjectContext.fetch(fetchCampaignRequest)
            updateCampaign = results.first!
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        let dataJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        if dataJSON?["Data"] != nil {
            for item in dataJSON?["Data"] as! [String: Any] {


                // Update Campaign
                switch item.key {
                case "Id":
                    updateCampaign.iDCampaign = item.value as! Int32
                case "Name":
                    updateCampaign.nameCampaign = (item.value as! String)
                case "Description":
                    updateCampaign.descriptionCampaign = (item.value as! String)
                case "CreatedAt":
                    updateCampaign.createAtCampaign = (item.value as! String)
                case "StartDate":
                    updateCampaign.startDateCampaign = (item.value as! String)
                case "EndDate":
                    updateCampaign.endDateCampaign = (item.value as! String)
                case "Banner":
                    updateCampaign.bannerCampaign = (item.value as! String)
                case "TypeCampaign":
                    updateCampaign.typeCampaign = (item.value as! String)
                case "GroupCampaign":
                    updateCampaign.groupCampaign = (item.value as! String)
                case "Distance":
                    updateCampaign.distanceCampaign = item.value as! Double
                case "TotalPointCampaign":
                    updateCampaign.totalPointCampaign = item.value as! Int32
                case "IsLogin":
                    updateCampaign.isLoginCampaign = item.value as! Bool
                case "HasSurvey":
                    updateCampaign.hasSurvey = item.value as! Bool
                case "ReceiveCampaign":
                    updateCampaign.receiveCampaign = (item.value as! String)
                case "IsReceive":
                    updateCampaign.isReceiveCampaign = item.value as! Bool
                case "Branch":
                    let setBranch: NSMutableSet = NSMutableSet()
                    for item1 in item.value as! [[String: Any]] {
                        let branchEntity = NSEntityDescription.entity(forEntityName: "Branch", in: managedContext)
                        currentBranch = Branch(entity: branchEntity!, insertInto: managedContext)

                        for item2 in item1 as [String: Any] {
                            switch item2.key {
                            case "Id":
                                currentBranch.idBranch = item2.value as! Int32
                            case "Name":
                                currentBranch.nameBranch = (item2.value as! String)
                            case "Address":
                                currentBranch.addressBranch = (item2.value as! String)
                            case "Lat":
                                currentBranch.latBranch = item2.value as! Double
                            case "Lng":
                                currentBranch.lngBranch = item2.value as! Double
                            default:
                                break
                            }
                        }
                       // print(currentBranch)
                        setBranch.add(currentBranch)
                    }
                    
                    updateCampaign.branchs = setBranch as NSSet
                    print(setBranch.count)
                    
                default:
                    break
                }
                
            }            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
    }

}
