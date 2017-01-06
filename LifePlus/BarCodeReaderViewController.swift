//
//  BarCodeReaderViewController.swift
//  LifePlus
//
//  Created by Javu on 1/6/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import UIKit
import MTBBarcodeScanner

class BarCodeReaderViewController: UIViewController {
    
    @IBOutlet weak var viewPreView: UIView!
    @IBOutlet weak var lblCode: UILabel!
    var scanner: MTBBarcodeScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: viewPreView)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scanner?.startScanning(resultBlock: { codes in
            let codesObjects = codes as! [AVMetadataMachineReadableCodeObject]?
            for code in codesObjects! {
                let stringValue = code.stringValue!
                self.lblCode.text = stringValue
            }
        }, error: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scanner?.stopScanning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
