//
//  AppDelegate.swift
//  MyApp
//
//  Created by ishwar lal janwa on 19/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
     let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var _tabbarController : CustomTabBarController!
    var tabbarController : CustomTabBarController?
    {
        get
        {
            if _tabbarController == nil
            {
               _tabbarController =  mainStoryboard
                .instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController
                _tabbarController .selectedIndex = 0
                
            }
            
            return _tabbarController
        }
        set
        {
            
        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Window root
        self.window = UIWindow (frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        self.tabbarController?.UpdateAccountTab(isLogin: true)
        self.window?.rootViewController = self.tabbarController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    
}

