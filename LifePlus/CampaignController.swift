//
//  APICampaignController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class CampaignController: NSObject {

    func getCampaignWithGroupName(groupName: String, callBack: @escaping (Array<Any>) -> ()) {
        let requestURL = NSMutableURLRequest()
        requestURL.url = URL(string: "https://api.lifeplusloyalty.vn/campaign?\(groupName)")
        requestURL.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        let task = urlSession.dataTask(with: requestURL as URLRequest, completionHandler: {(data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if (error == nil)  && (httpResponse?.statusCode == 200) {
                let dataJSON = try? JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                let dataArr = dataJSON?["Data"] as! Array<Any>
                callBack(dataArr)
            } else {
                let dataStatus = try? JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                print(dataStatus!)
            }
        })
        task.resume()
    }
}
