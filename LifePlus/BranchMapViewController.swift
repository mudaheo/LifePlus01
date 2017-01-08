//
//  BranchMapViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/8/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BranchMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var currentMerchant: Merchant!
    var branchList: [Branch]!
    let color1: String = "00A73D"
    let color2: String = "52C458"
    
    
    @IBOutlet weak var branchMapView: MKMapView!
    @IBOutlet weak var merchantImageView: UIImageView!
    @IBOutlet weak var branchTableView: UITableView!
    let locationManager : CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            
           merchantImageView.image = try UIImage(data: Data(contentsOf: URL(string: currentMerchant.merchantLogo!)!))
            merchantImageView.layer.cornerRadius = merchantImageView.frame.width/2
            merchantImageView.clipsToBounds = true
            merchantImageView.layer.borderColor = UIColor.lightGray.cgColor
            merchantImageView.layer.borderWidth = 1.0
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            branchMapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        branchMapView.delegate = self
        
        let currentBranch: Branch = branchList.first!
        loadLoactionBranch(currentBranch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLoactionBranch(_ branch: Branch) {
        let myCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: branch.latBranch, longitude: branch.lngBranch)
        let region : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 1000, 1000)
        branchMapView.setRegion(region, animated: true)
        addAnnotationOnLocation(myCoordinate, branch)
    }
    func addAnnotationOnLocation(_ coordinate : CLLocationCoordinate2D, _ branch: Branch) {
        let point : MKPointAnnotation = MKPointAnnotation()
        point.coordinate = coordinate
        point.title = branch.nameBranch
        point.subtitle = branch.addressBranch
        branchMapView.addAnnotation(point)
        
    }
    

}
extension BranchMapViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BranchMapTableViewCell
        let branch: Branch = branchList[indexPath.row]
        cell.branchAddressLabel.text = branch.addressBranch
        if indexPath.row % 2 == 0 {
            cell.myView.backgroundColor = UIColor(hex: color1, alpha: 1.0)
        }else{
            cell.myView.backgroundColor = UIColor(hex: color2, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentBranch: Branch = branchList[indexPath.row]
        loadLoactionBranch(currentBranch)
    }
}
