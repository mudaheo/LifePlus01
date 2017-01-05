//
//  SearchViewController.swift
//  LifePlus
//
//  Created by Javu on 1/3/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tbvCampaign: UITableView!
    @IBOutlet weak var sebCampaign: UISearchBar!
    
    var searchController: UISearchController!
    
    var campaign = CampaignController()
    var campaignArr: [Campaign] = [Campaign]()
    
    var campainNamesArr = [String]()
    var filterArr = [String]()
    
    var searchActive = false
    var lblMessage = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TÌM KIẾM"
        let nib: UINib = UINib(nibName: "CustomCell", bundle: nil)
        tbvCampaign.register(nib, forCellReuseIdentifier: "Cell")
        campaign.getCampaignWithGroupName(groupName: "") { (dataArr) in
            self.getData(dataArr: dataArr)
            DispatchQueue.main.async {
                self.tbvCampaign.reloadData()
            }
        }
        
        
    }
    
    func getData(dataArr: Array<Any>) {
        if campaignArr.count == 0 {
            for item in dataArr{
                let item = item as! Dictionary<String, Any>
                let aCampaign = Campaign()
                aCampaign.name = (item["Name"] as? String)!
                aCampaign.imageLink = (item["Banner"] as? String)!
                campaignArr.append(aCampaign)
                campainNamesArr.append(aCampaign.name)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filterArr.count
        }
        return campaignArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        if searchActive {
            cell.lblName.text = filterArr[indexPath.row]
            
        } else {
            let aCampaign = campaignArr[indexPath.row]
            cell.lblName.text = aCampaign.name
            cell.imvItem.image = try! UIImage(data: Data(contentsOf: URL(string: aCampaign.imageLink)!))
        }
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true
        
        filterArr = campainNamesArr.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchBar.text!, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filterArr.count == 0){
            searchActive = false;
            tbvCampaign.isHidden  = true
            
            if lblMessage.superview === self.view {
                lblMessage.isHidden = false
            } else {
                lblMessage = UILabel.init(frame: CGRect(x: view.frame.size.width / 2 - 80, y: view.frame.size.height / 2 - 15, width: 160, height: 30))
                lblMessage.text = "Không có dữ liệu"
                lblMessage.textAlignment = .center
                view.addSubview(lblMessage)
            }
        } else {
            searchActive = true;
            lblMessage.isHidden = true
            tbvCampaign.isHidden = false
        }
        self.tbvCampaign.reloadData()
        sebCampaign.resignFirstResponder()
    }
}




