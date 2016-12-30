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
            foodViewController.title = "Ăn gì?"
            
            let buyViewController = storyboard.instantiateViewController(withIdentifier: "BuyTableViewController")
            buyViewController.title = "Mua gì?"
            
            let placeViewController = storyboard.instantiateViewController(withIdentifier: "PlaceTableViewController")
            placeViewController.title = "Đi đâu?"
            
//            let view = getSegmentTabWithImage("OT")
//            foodViewController.navigationItem.titleView = view
            
            headerViewController = headerController
            segmentControllers = [foodViewController, buyViewController, placeViewController]
            headerViewHeight = 300
            selectedSegmentViewHeight = 5.0
            segmentTitleColor = .gray
            segmentViewHeight = 70
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            delegate = self
        
        }
        super.viewDidLoad()
    }
    
    //Use for custom Tab view.
    func getSegmentTabWithImage(_ imageName: String) -> UIView {
        let view = UIImageView()
        view.frame.size.width = self.view.frame.width / 3
        view.image = UIImage(named: "OT")
        view.contentMode = .scaleToFill
        view.backgroundColor = .orange
        
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
        }
        switch index {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("Error")
        }
    }
}

