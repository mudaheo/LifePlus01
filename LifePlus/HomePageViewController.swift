//
//  HomePageViewController.swift
//  LifePlus
//
//  Created by Javu on 12/28/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class HomePageViewController: SJSegmentedViewController {
    
    var selectedSegment: SJSegmentTab?
    
    override func viewDidLoad() {
        
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        if let storyboard = self.storyboard {
            let headerController = storyboard.instantiateViewController(withIdentifier: "HeaderViewController")
            
            let foodViewController = storyboard.instantiateViewController(withIdentifier: "FoodTableViewController")
            foodViewController.title = "Ăn gì?"
            
            let buyViewController = storyboard.instantiateViewController(withIdentifier: "BuyTableViewController")
            buyViewController.title = "Mua gì?"
            
            let placeViewController = storyboard.instantiateViewController(withIdentifier: "PlaceTableViewController")
            placeViewController.title = "Đi đâu?"
            
            headerViewController = headerController
            segmentControllers = [foodViewController, buyViewController, placeViewController]
            headerViewHeight = self.view.frame.height / 3
            
            segmentViewHeight = 50.0
            delegate = self
            selectedSegmentViewHeight = 0.0
            segmentTitleColor = .darkGray
            segmentBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"Banner"), for: .default)
        super.viewDidLoad()
        searchButton()
    }
    
    func searchButton() {
        let searchButton = UIButton()
        searchButton.frame = CGRect(x: view.frame.size.width - 80.0, y: view.frame.height - 120.0, width: 50.0, height: 50.0)
        searchButton.setImage(UIImage(named: "btn_search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchClick), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    @objc func searchClick() {
        let searchView = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")
        self.navigationController?.pushViewController(searchView!, animated: true)
    }
    
    //    func getSegmentTabWithImage(_ imageName: String) -> UIView {
    //        let view = UIImageView()
    //        view.frame.size.width  = 100
    //        view.image = UIImage(named: imageName)
    //        view.contentMode = .scaleAspectFit
    //        view.backgroundColor = .white
    //
    //        return view
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension HomePageViewController: SJSegmentedViewControllerDelegate{
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            selectedSegment?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            selectedSegment?.titleColor(.darkGray)
        }
        if segments.count > 0 {
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.init(white: 1, alpha: 0))
            UIGraphicsBeginImageContext(self.view.frame.size)
            var image = UIImage()
    
            if index == 0 {
                image = UIImage(named: "ic_angiNoIcon_act")!
            }
            if index == 1 {
                image = UIImage(named: "ic_muagiNoIcon_act")!
            }
            if index == 2 {
                image = UIImage(named: "ic_didauNoIcon_act")!
            }
            
            image.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3/*120*/, height: 50))
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            selectedSegment?.backgroundColor = UIColor(patternImage: image)
        }
    }
    
}

