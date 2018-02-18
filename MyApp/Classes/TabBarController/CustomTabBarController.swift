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
       // self.tabBar.delegate  = self
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
            self.viewControllers?[4] = UINavigationController(rootViewController: (self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController"))!)
            self.tabBar.items![4].image = UIImage(named: "account")
            self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        return true
        //return shouldSelect
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) 
    {
        
        shouldSelect = item.tag != 2
        
    }
}
