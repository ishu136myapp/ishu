//
//  LoginViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class LoginViewController: SuperViewController {

    @IBOutlet var btnClose : UIButton!
    @IBOutlet var btnSkip : UIButton!
    @IBOutlet var btnSignIn : UIButton!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPassword : UITextField!
    
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

        btnSignIn.layer.cornerRadius = 5
        btnSignIn.layer.masksToBounds = true
        
    }

    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSignInClicked(sender : UIButton)
    {
        let changePasswordVC = appDelegate?.mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    @IBAction func btnForgotPasswordClicked(sender : UIButton)
    {
        let forgotVC = appDelegate?.mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func btnSignUpClicked(sender : UIButton)
    {
        let signUpVC = appDelegate?.mainStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func btnFacebookClicked(sender : UIButton)
    {
        let editProfile = appDelegate?.mainStoryboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        
        self.navigationController?.pushViewController(editProfile, animated: true)
    }
    
    @IBAction func btnGoogleClicked(sender : UIButton)
    {
        
    }
    
    @IBAction func btnSkipClicked(sender : UIButton)
    {
        
    }
    
    @IBAction func btnCloseClicked(sender : UIButton)
    {
        
    }
}
