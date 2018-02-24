//
//  ChangePasswordViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 25/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class ChangePasswordViewController: SuperViewController {

    @IBOutlet var btnSubmit : UIButton!
    @IBOutlet var txtoldPassword : UITextField!
    @IBOutlet var txtNewPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!
    
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
        self.title = "CHANGE PASSWORD"
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = true
        
    }
    
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSubmitClicked(sender : UIButton)
    {
        
    }

}
