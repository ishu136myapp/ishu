//
//  CustomTabBarController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 16/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate
{
    var shouldSelect : Bool = true
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func UpdateAccountTab(isLogin : Bool)
    {
        if isLogin
        {
            self.viewControllers?[4] = UINavigationController(rootViewController: (self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController"))!)
            self.tabBar.items![4].image = UIImage(named: "account")
            self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0)
        }
        else
        {
            self.viewControllers?[4] = UINavigationController(rootViewController: (self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController"))!)
            self.tabBar.items![4].image = UIImage(named: "account")
            self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0)
            self.tabBar.items![4].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 50)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        if !shouldSelect
        {
            var  alertVW  = UIView()
            alertVW  = SignInRequiredPop.alertViewWithHandler(handler: { (index, title) in
                
                self.dismissPopUp(view: alertVW, completionHandler: {
                })
                
                if (index == 0)
                {
                    let login = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    login.initateType = .fromTabbar
                    self.present(UINavigationController(rootViewController: login), animated: true, completion: {})
                    
                }else if (index == 1)
                {
                    let signUp = mainStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                    signUp.initateType = .fromTabbar
                    self.present(UINavigationController(rootViewController: signUp), animated: true, completion: {})
                }
            })
            self.presentPopUp(view: alertVW, shouldOutSideClick: true, type: .center, completionHandler: {
                
            })
        }
       
        return shouldSelect
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) 
    {
        self.tabBar.items![4].title = ""
        if item.tag == 2
        {
            shouldSelect = (appDelegate?.isLogin)!
        }
        else
        {
            shouldSelect  = true
        }
        
    }
}
