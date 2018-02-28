//
//  AppDelegate.swift
//  MyApp
//
//  Created by ishwar lal janwa on 19/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit
import SDWebImage
import IQKeyboardManagerSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLogin : Bool = false
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
        // IQKeyboarManager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        // Window root
        self.window = UIWindow (frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let login = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        login.initateType = .firstTime
        self.window?.rootViewController = UINavigationController(rootViewController: login)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    func setWindowRootVC(_ vc: UIViewController, animated: Bool, completion completed: @escaping (_ finished: Bool) -> Void)
    {
        UIView.transition(with: window!, duration: animated ? 0.3 : 0.0, options: .transitionCrossDissolve, animations: {() -> Void in
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window?.rootViewController = vc
            UIView.setAnimationsEnabled(oldState)
            
        }, completion: {(_ finished: Bool) -> Void in
            
            completed(finished)
            
        })
    }
}

