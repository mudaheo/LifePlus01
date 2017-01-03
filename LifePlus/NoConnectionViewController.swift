//
//  NoConnectionViewController.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/2/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit

class NoConnectionViewController: UIViewController {

    @IBOutlet weak var tryAgainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.size.height/2
        tryAgainButton.clipsToBounds = true
        tryAgainButton.layer.borderWidth = 0.5
        tryAgainButton.layer.borderColor = UIColor.black.cgColor
        
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
    @IBAction func handleTryAgainButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
