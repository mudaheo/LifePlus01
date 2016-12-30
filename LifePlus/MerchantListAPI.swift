//
//  MerchantListAPI.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/29/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import CoreData

class MerchantListAPI: NSObject {
    
    let coreDataStack: CoreDataStack = CoreDataStack()
    var managedContext: NSManagedObjectContext!
    
    //var merchantList: [Merchant] = [Merchant]()
    var currentMerchant: Merchant!
    
    func requestMerchantList(_ callBackResponse: @escaping ([String]) -> ()) {
        
        managedContext = coreDataStack.managedObjectContext
        
        
        if currentReachabilityStatus != .notReachable {
            let request: NSMutableURLRequest = NSMutableURLRequest()
            request.httpMethod = "GET"
            request.url = URL(string: "https://api.lifeplusloyalty.vn/merchant")
            
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            let urlSeason: URLSession = URLSession(configuration: config)
            let task = urlSeason.dataTask(with: request as URLRequest) { (data, response, error) in
                //let message: String = String.init(data: data!, encoding: .utf8)!
                var statusCode: Int = 0
                if let httpRespose: HTTPURLResponse = response as? HTTPURLResponse {
                    statusCode = httpRespose.statusCode
                }
                
                if statusCode == 200 {
                    let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    self.parseMerchantListJSON(parsedData!)
                    
                }else{
                    let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    if (parsedData?["Status"] != nil){
                        callBackResponse([parsedData?["Status"] as! String])
                    }
                }
                
                
            }
            task.resume()
        }else {
            callBackResponse(["noconnection"])
        }
    }
    
   private func parseMerchantListJSON(_ dataJSON: [String: Any]) {
        if dataJSON["Data"] != nil {
            for item in dataJSON["Data"] as! [[String: Any]] {
                
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
