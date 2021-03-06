//
//  BookmarkDetailsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 31/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit
enum CreatedUserType {
    case mine
    case Other
}

class BookmarkDetailsViewController: SuperViewController
{
    var CreateUserType : CreatedUserType = .Other
    @IBOutlet var tblFeed : UITableView!
    @IBOutlet var vWNavigation : UIView!
    @IBOutlet var vwTbleHeader : UIView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var btnBookMark : UIButton!
    
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
        //...
        vWNavigation.backgroundColor =  CRGBA(r: 0, g: 0, b: 0, a: 0.3)
        lblTitle.text = self.iObject as? String
        tblFeed.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsTableViewCell")
        tblFeed.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "TextNewsTableViewCell")
        
        vwTbleHeader.frame = CGRect(x: 0, y: 0, width: CScreenWidth, height: (260/375*CScreenWidth))
        tblFeed.tableHeaderView = vwTbleHeader
        
        //. this bookmark created by me

        if self.CreateUserType == .mine
        {
            btnBookMark.setImage(UIImage(named: "more_white"), for: .normal)
        }
        
    }
    
    // MARK: -
    // MARK: - loadData
    
    
    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnBookMarkClicked(sender : UIButton)
    {
        if self.CreateUserType == .mine
        {
            //is created by me for edit and delete option
            var  option  = UIView()
            option  = OptionView.OptionViewWithHandler(optionType: .MyPost, handler: { (Index, title) in
                
                self.dismissPopUp(view: option, completionHandler: {
                    
                })
                
            })
            self.presentPopUp(view: option, shouldOutSideClick: true, type: .bottom, completionHandler: {
                
            })
            
        }
        else
        {
            sender.isSelected = !sender.isSelected
        }

    }
}

// MARK: -
// MARK: - UITable view Data Source and Delegate

extension BookmarkDetailsViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row
        {
        case 0:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            return cell
            
        case 1:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = ""
            return cell
            
        case 2:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = ""
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
            
        case 3 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            
            return cell
            
        case 4 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = ""
            return cell
            
        case 5 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = ""
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
            
        default:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let NewsDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        self.navigationController?.pushViewController(NewsDetailsVC, animated: true)
    }
}
