//
//  PlaceTableViewController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class PlaceTableViewController: UITableViewController {
    
    
    @IBOutlet var placeTableView: UITableView!
    var placeArr = [Place]()
    var camp = CampaignController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        placeTableView.register(nib, forCellReuseIdentifier: "Cell")
        
        camp.delegate = self
        camp.getCampaignWithGroupName(groupName: "group=place")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        let aPlace = placeArr[indexPath.row]
        cell.lblName.text = aPlace.name
        cell.imvItem.image = try! UIImage(data: Data(contentsOf: URL(string: aPlace.imageLink)!))
        
        return cell
    }
}

extension PlaceTableViewController: CampaignControllerDelegate {
    func getDataWithCampaignFromAPI(dataArr: Array<Any>) {
        getData(dataArr: dataArr)
        DispatchQueue.main.async {
            self.placeTableView.reloadData()
        }
    }
    
    func getData(dataArr: Array<Any>) {
        if placeArr.count == 0 {
            for item in dataArr{
                let item = item as! Dictionary<String, Any>
                let aPlace = Place()
                aPlace.name = (item["Name"] as? String)!
                aPlace.imageLink = (item["Banner"] as? String)!
                placeArr.append(aPlace)
            }
        }
    }
}
