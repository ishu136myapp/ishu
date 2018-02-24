//
//  ForgotPasswordViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: SuperViewController {

    @IBOutlet var btnSubmit : UIButton!
    @IBOutlet var txtEmail : UITextField!
    
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
        self.title = "FORGOT PASSWORD"
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = true
        
    }
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSubmitClicked(sender : UIButton)
    {
        
    }

}
