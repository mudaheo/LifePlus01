//
//  FoodTableViewController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    @IBOutlet var foodTableView: UITableView!
    var foodArr = [Food]()
    var campaign = CampaignController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        foodTableView.register(nib, forCellReuseIdentifier: "Cell")
        campaign.getCampaignWithGroupName(groupName: "group=food") { (
            arayData) in
            self.getData(dataArr: arayData)
            DispatchQueue.main.async {
                self.foodTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData(dataArr: Array<Any>) {
        if foodArr.count == 0 {
            for item in dataArr{
                let item = item as! Dictionary<String, Any>
                let aFood = Food()
                aFood.name = (item["Name"] as? String)!
                aFood.imageLink = (item["Banner"] as? String)!
                foodArr.append(aFood)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        let aFood = foodArr[indexPath.row]
        cell.lblName.text = aFood.name
        cell.imvItem.image = try! UIImage(data: Data(contentsOf: URL(string: aFood.imageLink)!))
        
        return cell
    }
}
