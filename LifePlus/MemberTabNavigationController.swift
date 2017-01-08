//
//  MemberTabNavigationController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/8/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class MemberTabNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.greenLifePlus
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
