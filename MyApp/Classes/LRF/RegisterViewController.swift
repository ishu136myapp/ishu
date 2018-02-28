//
//  RegisterViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class RegisterViewController: SuperViewController {

    var initateType : initiateType = .firstTime
    @IBOutlet var imgVProfile : UIImageView!
    @IBOutlet var btnSignUp : UIButton!
    @IBOutlet var btnAcceptTC : UIButton!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!
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
        self.title = "SIGN UP"
        btnSignUp.layer.cornerRadius = 5
        btnSignUp.layer.masksToBounds = true
        if initateType == .fromTabbar
        {
            let image =   UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            let barBtnSetting = UIBarButtonItem(image: image, style: .plain, target: self, action:#selector(self.btnBackClicked(_:)))
            self.navigationItem.leftBarButtonItem = barBtnSetting
        }
        
    }
    
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSignUpClicked(sender : UIButton)
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
    @IBAction func btnAcceptTermAndConditionClicked(sender : UIButton)
    {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnTermsConditionClicked(sender : UIButton)
    {
        let termsVC = mainStoryboard.instantiateViewController(withIdentifier: "TermsAncConditionViewController") as! TermsAncConditionViewController
        
        self.present(UINavigationController(rootViewController: termsVC), animated: true, completion: nil)
        
    }
    
}
