//
//  OptionView.swift
//  MyApp
//
//  Created by ishwar lal janwa on 06/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

typealias optionHandler = (_ option:Int?, _ title:String?) -> Void

enum optionType
{
    case OtherUserPost
    case MyPost
}

class OptionView: UIView
{
   @IBOutlet var tblOption : UITableView!
    var optionHandler : optionHandler?
    var optionType : optionType?
    var arrOption : Array<Any>?
    
    class func OptionViewWithHandler(optionType : optionType?, handler : optionHandler?) -> OptionView
    {
        let optionVW = Bundle.main.loadNibNamed("OptionView", owner: nil, options: nil)![0] as? OptionView
        optionVW?.optionHandler = handler
        optionVW?.optionType = optionType
        optionVW?.CViewSetWidth(width: CScreenWidth)
        optionVW?.initialize()
        let height = optionVW?.tblOption.contentSize.height
        optionVW?.CViewSetHeight(height: height!)
        return optionVW!
    }
    
    func initialize()
    {
        self.tblOption.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")

        switch self.optionType!
        {
            case .OtherUserPost:
            
            self.arrOption = [["icon":"",
                               "title":"Feedback"],
                              ["icon":"",
                               "title":"Spam"],
                              ["icon":"",
                               "title":"Nudity"],
                              ["icon":"",
                               "title":"Irrelevant HashTag"],
                              ["icon":"",
                               "title":"Bookmark all HashTag"],
                              ["icon":"",
                               "title":"Cancle"]]
            
            case .MyPost :
            
                self.arrOption = [["icon":"",
                                   "title":"Edit"],
                                  ["icon":"",
                                   "title":"Delete"],
                                  ["icon":"",
                                   "title":"Cancle"]]
        }
        
        self.tblOption.reloadData()
    }
}

extension OptionView : UITableViewDelegate,UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrOption?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblOption.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
        
        if let dict = self.arrOption?[indexPath.row] as? [String : Any]
        {
            cell.lblTitle.text = dict.valueForString(key: "title")
            cell.imgVIcon.image = UIImage(named: dict.valueForString(key: "icon"))
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let dict = self.arrOption?[indexPath.row] as? [String : Any]
        {
            if (self.optionHandler != nil)
            {
                self.optionHandler!(indexPath.row,dict.valueForString(key: "title"))
            }
        }
        
    }
}
