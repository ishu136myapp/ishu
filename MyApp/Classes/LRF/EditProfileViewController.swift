//
//  EditProfileViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 25/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class EditProfileViewController: SuperViewController {

    @IBOutlet var btnSubmit : UIButton!
    @IBOutlet var imgVProfile : UIImageView!
    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtProfession : UITextField!
    
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
        self.title = "EDIT PROFILE"
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = true
        self.imgVProfile.layer.cornerRadius = (CScreenWidth/3)/2
        self.imgVProfile.layer.masksToBounds = true;
    }
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSubmitClicked(sender : UIButton)
    {
        
    }

    @IBAction func btnProfileClicked(sender : UIButton)
    {
        self.presentImagePickerController(allowEditing: true, imagePickerControllerCompletionHandler: { (image
            , dict) in
            
            self.imgVProfile.image = image
            self.imgVProfile.layer.cornerRadius = self.imgVProfile.CViewWidth / 2
            self.imgVProfile.layer.masksToBounds = true;
        })
    }
}
