//
//  BuyTableViewController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class BuyTableViewController: UITableViewController {
    
    @IBOutlet var buyTableView: UITableView!
    var buyArr = [Buy]()
    var campain = CampaignController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        buyTableView.register(nib, forCellReuseIdentifier: "Cell")
        campain.getCampaignWithGroupName(groupName: "group=buy") { (dataArr) in
            self.getData(dataArr: dataArr)
            DispatchQueue.main.async {
                self.buyTableView.reloadData()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData(dataArr: Array<Any>) {
        if buyArr.count == 0 {
            for item in dataArr{
                let item = item as! Dictionary<String, Any>
                let aBuy = Buy()
                aBuy.name = (item["Name"] as? String)!
                aBuy.imageLink = (item["Banner"] as? String)!
                buyArr.append(aBuy)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return buyArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        let aBuy = buyArr[indexPath.row]
        cell.lblName.text = aBuy.name
        cell.imvItem.image = try! UIImage(data: Data(contentsOf: URL(string: aBuy.imageLink)!))
        
        return cell
    }
}
