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
    
    let baseURL: String = "https://api.lifeplusloyalty.vn"
    let myData: Data = Data()
    
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

}
