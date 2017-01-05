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
        
        if let storyboard = self.storyboard {
            let headerController = storyboard.instantiateViewController(withIdentifier: "HeaderViewController")
            
            let foodViewController = storyboard.instantiateViewController(withIdentifier: "FoodTableViewController")
            
            
            
            
            // Custom ImageView
            let view = UIImageView()
            
            view.image = UIImage(named: "ic_muagiNoIcon_act")
            view.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            foodViewController.navigationItem.titleView = view
            
            
            
            
            
            
            foodViewController.title = "Ăn gì?"
            let buyViewController = storyboard.instantiateViewController(withIdentifier: "BuyTableViewController")
            
            buyViewController.title = "Mua gì?"
            //          buyViewController.navigationItem.titleView = getSegmentTabWithImage("ic_muagiNoIcon_act")
            
            let placeViewController = storyboard.instantiateViewController(withIdentifier: "PlaceTableViewController")
            placeViewController.title = "Đi đâu?"
            //          placeViewController.navigationItem.titleView = getSegmentTabWithImage("ic_didauNoIcon_act")
            
            headerViewController = headerController
            segmentControllers = [foodViewController, buyViewController, placeViewController]
            headerViewHeight = self.view.frame.height / 3
            
            segmentViewHeight = 50.0
            segmentShadow = SJShadow.light()
            delegate = self
            selectedSegmentViewHeight = 0.0
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
    
    //Use for custom Tab view. (Not yet use...)
    func getSegmentTabWithImage(_ imageName: String) -> UIView {
        let view = UIImageView()
        view.frame.size.width  = 100
        view.image = UIImage(named: imageName)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomePageViewController: SJSegmentedViewControllerDelegate{
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        if segments.count > 0 {
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)

            
            
            //            let segment1 = segmentControllers[index]
            //            if index == 0 {
            //                let view = UIImageView()
            ////                view.frame.size.width  = 100
            //                view.image = UIImage(named: "ic_angiNoIcon_act")
            //                view.contentMode = .scaleAspectFit
            //                view.backgroundColor = .blue
            //                segment1.navigationItem.titleView = view
            //                print("0")
            //
            //            }
            //            if index == 1 {
            //                let view = UIImageView()
            //                view.frame.size.width  = 100
            //                view.image = UIImage(named: "ic_muagiNoIcon_act")
            //                view.contentMode = .scaleAspectFit
            //                view.backgroundColor = .white
            //                segment1.navigationItem.titleView = view
            //                print("1")
            //            }
            //            if index == 2 {
            //                let view = UIImageView()
            //                view.frame.size.width  = 100
            //                view.image = UIImage(named: "ic_didauNoIcon_act")
            //                view.contentMode = .scaleAspectFit
            //                view.backgroundColor = .white
            //                segment1.navigationItem.titleView = view
            //                print("2")
            //            }
            
        }
    }
    
}

