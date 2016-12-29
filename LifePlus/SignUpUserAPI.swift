//
//  SignUpUserAPI.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class SignUpUserAPI: NSObject {
    
    func requestSignUpUser(_ id: Int32,_ email: String,_ password: String,_ phone: String,_ callBackResponse: @escaping ([String]) -> ()) {
        
        if currentReachabilityStatus != .notReachable {
            
            let request: NSMutableURLRequest = NSMutableURLRequest()
            request.httpMethod = "POST"
            request.url = URL(string: "https://api.lifeplusloyalty.vn/merchant/\(id)/signup")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let paramBody: [String: Any] = [
                "Email":"\(email)",
                "Password":"\(password)",
                "Phone":"\(phone)",
                "Info":[[
                    "FieldTable": "gender",
                    "Value" :"male"
                    ]]
            ]
            
            
            let data = try! JSONSerialization.data(withJSONObject: paramBody, options: .prettyPrinted)
            
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
            
            
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            let urlSeason: URLSession = URLSession(configuration: config)
            let task = urlSeason.dataTask(with: request as URLRequest) { (data, response, error) in
                //let message: String = String.init(data: data!, encoding: .utf8)!
                var statusCode: Int = 0
                if let httpRespose: HTTPURLResponse = response as? HTTPURLResponse {
                    statusCode = httpRespose.statusCode
                }
                
                if statusCode == 200 {
                    callBackResponse(["success"])
                    
                }else{
                    var messageArr: [String] = [String]()
                    let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    if (parsedData?["Fields"] != nil) {
                        for message in parsedData!["Fields"] as! [[String: String]]{
                            messageArr.append(message["Message"]!)
                        }
                        
                        callBackResponse(messageArr)
                    }
                }
                
                
            }
            task.resume()
        }else {
            //Connection
            callBackResponse(["noconnection"])
        }
        
    }
        



}
