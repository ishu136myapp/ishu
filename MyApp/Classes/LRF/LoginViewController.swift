//
//  LoginViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit
enum initiateType {
    case firstTime
    case fromTabbar
}

class LoginViewController: SuperViewController {

    var initateType : initiateType = .firstTime
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
        
        if initateType == .firstTime
        {
            btnSkip.isHidden = false
            btnClose.isHidden = true
        }
        else
        {
            btnSkip.isHidden = true
            btnClose.isHidden = false
        }
        
    }

    func login()
    {
        self.dismiss(animated: true, completion: {
            
        })
        appDelegate?.isLogin = true
        appDelegate?._tabbarController = nil
        appDelegate?.tabbarController?.UpdateAccountTab(isLogin: true)
        appDelegate?.setWindowRootVC((appDelegate?.tabbarController)!, animated: true, completion: { (complition) in
            
        })
    }
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnSignInClicked(sender : UIButton)
    {
        if (self.initateType == .fromTabbar)
        {
            self.dismiss(animated: true, completion: {
                
            })
            appDelegate?.isLogin = true
            appDelegate?._tabbarController = nil
            appDelegate?.tabbarController?.UpdateAccountTab(isLogin: true)
            appDelegate?.setWindowRootVC((appDelegate?.tabbarController)!, animated: true, completion: { (complition) in
                
            })
            
        }
        else
        {
            self.login()
        }
        
    }
    
    @IBAction func btnForgotPasswordClicked(sender : UIButton)
    {
        let forgotVC = mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func btnSignUpClicked(sender : UIButton)
    {
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func btnFacebookClicked(sender : UIButton)
    {
        self.login()
    }
    
    @IBAction func btnGoogleClicked(sender : UIButton)
    {
        self.login()
    }
    
    @IBAction func btnSkipClicked(sender : UIButton)
    {
        self.dismiss(animated: true, completion: {
            
        })
        appDelegate?.isLogin = false
        appDelegate?._tabbarController = nil
        appDelegate?.tabbarController?.UpdateAccountTab(isLogin: false)
        appDelegate?.setWindowRootVC((appDelegate?.tabbarController)!, animated: true, completion: { (complition) in
            
        })
    }
    
    @IBAction func btnCloseClicked(sender : UIButton)
    {
        self.dismiss(animated: true) {}
    }
}
