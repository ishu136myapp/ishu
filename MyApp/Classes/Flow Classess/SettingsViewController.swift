//
//  SettingsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 29/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class SettingsViewController: SuperViewController {
    
    @IBOutlet var tblSetting : UITableView!
    var arrSettings : Array<Any>?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    func initialize()
    {
        self.tblSetting.isScrollEnabled = false
        if (appDelegate?.isLogin)!
        {
            self.title = "Settings"
            
            arrSettings = [["title":"Change Password",
                            "icon":#imageLiteral(resourceName: "changePassword")],
                           ["title":"Notification Settings",
                            "icon":#imageLiteral(resourceName: "notification_gray")],
                           ["title":"Terms and Conditions",
                            "icon":#imageLiteral(resourceName: "privacy")],
                           ["title":"Report a Problem",
                            "icon":#imageLiteral(resourceName: "report")],
                           ["title":"Contact Us",
                            "icon":#imageLiteral(resourceName: "contact")],
                           ["title":"About Us",
                            "icon":#imageLiteral(resourceName: "aboutus")],
                           ["title":"Log Out",
                            "icon":#imageLiteral(resourceName: "logout")]]
        }
        else
        {
            self.title = "Account"
            arrSettings = [["title":"Login",
                            "icon":#imageLiteral(resourceName: "login")],
                           ["title":"Bookmark List",
                            "icon":#imageLiteral(resourceName: "bookmark_unselected")],
                           ["title":"Notification Settings",
                            "icon":#imageLiteral(resourceName: "notification_gray")],
                           ["title":"Terms and Conditions",
                            "icon":#imageLiteral(resourceName: "privacy")],
                           ["title":"Report a Problem",
                            "icon":#imageLiteral(resourceName: "report")],
                           ["title":"Contact Us",
                            "icon":#imageLiteral(resourceName: "contact")],
                           ["title":"About Us",
                            "icon":#imageLiteral(resourceName: "aboutus")]]
        }

        //...
        tblSetting.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
}

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrSettings?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblSetting.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        if let dict = self.arrSettings![indexPath.row] as?  [String : Any]
        {
            cell.lblTitle.text = dict.valueForString(key: "title")
            cell.imgVUser.image = dict["icon"] as? UIImage
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
     
        if (appDelegate?.isLogin)!
        {
            switch(indexPath.row)
            {
            case 0 : // Change Password
                let changePasswordVC = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
                self.navigationController?.pushViewController(changePasswordVC, animated: true)
                break
            case 1 : // Notification Settings
                
                let notificationSettingVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationSettingViewController") as! NotificationSettingViewController
                self.navigationController?.pushViewController(notificationSettingVC, animated: true)
                break
            case 2 : // Terms and Conditions
                let termVc = mainStoryboard.instantiateViewController(withIdentifier: "TermsAncConditionViewController") as! TermsAncConditionViewController
                self.present(UINavigationController(rootViewController: termVc), animated: true, completion: {
                    
                })
                break
            case 3: // Report a Problem
                break
            case 4 : // Contact Us
                break
            case 5 :// About Us
                break
            case 6 :// Log Out
                appDelegate?.isLogin = false
                appDelegate?._tabbarController = nil
                appDelegate?.tabbarController?.UpdateAccountTab(isLogin: false)
                appDelegate?.setWindowRootVC((appDelegate?.tabbarController)!, animated: true, completion: { (complition) in
                    
                })
                break
            default:
                break
            }
            
        }
        else
        {
            switch(indexPath.row)
            {
            case 0 : // Login
                let login = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                login.initateType = .fromTabbar
                self.present(UINavigationController(rootViewController: login), animated: true, completion: {})
                break
            case 1 : // Bookmark List
                let bookmarkList = mainStoryboard.instantiateViewController(withIdentifier: "BookmarkListViewController") as! BookmarkListViewController
                
                bookmarkList.tagType = .BookmarkList
                self.navigationController?.pushViewController(bookmarkList, animated: true)
                break
            case 2: // Notification Settings
                let notificationSettingVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationSettingViewController") as! NotificationSettingViewController
                self.navigationController?.pushViewController(notificationSettingVC, animated: true)
                break
            case 3 : // Terms and Conditions
                let termVc = mainStoryboard.instantiateViewController(withIdentifier: "TermsAncConditionViewController") as! TermsAncConditionViewController
                self.present(UINavigationController(rootViewController: termVc), animated: true, completion: {
                    
                })
                break
            case 4 : // Report a Problem
                break
            case 5 : // Contact Us
                break
            case 6 : // About Us
                break
            default:
                break
            }
        }
    }
}
