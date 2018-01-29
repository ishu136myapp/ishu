//
//  SettingsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 29/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class SettingsViewController: SuperViewController,  UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tblSetting : UITableView!
    var arrSettings : Array<Any>?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    func initialize()
    {
        self.title = "Settings"
        arrSettings = [["title":"Notification Settings",
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
        //...
        tblSetting.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
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
    
}
