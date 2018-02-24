//
//  TermsAncConditionViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class TermsAncConditionViewController: SuperViewController {

    @IBOutlet var txtVDescription : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    func initialize()
    {
        self.title = "TERMS AND CONDITION"
        let image =   UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let barBtnSetting = UIBarButtonItem(image: image, style: .plain, target: self, action:#selector(self.btnBackClicked(_:)))
        self.navigationItem.leftBarButtonItem = barBtnSetting
    }
    


}
