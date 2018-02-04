//
//  AccountViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 28/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class AccountViewController: SuperViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgVUser : UIImageView!
    @IBOutlet weak var vWimgUser : UIView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblProfession : UILabel!
    @IBOutlet weak var lblPostCount : UILabel!
    @IBOutlet weak var lblLikedCount : UILabel!
    @IBOutlet weak var lblTagsCount : UILabel!
    @IBOutlet weak var lblBookMarkCount : UILabel!
    @IBOutlet weak var btnEditProfile : UIButton!
    
    @IBOutlet var tblView : UITableView!
    @IBOutlet var cnHeaderTop: NSLayoutConstraint!
    var refreshControl : UIRefreshControl!
    
    
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
        imgVUser.layer.cornerRadius = imgVUser.CViewWidth / 2
        imgVUser.layer.masksToBounds = true
        
        vWimgUser.layer.cornerRadius = vWimgUser.CViewWidth / 2
        vWimgUser.layer.masksToBounds = true
        vWimgUser.layer.borderColor = CColorTheme_760AFF.cgColor
        vWimgUser.layer.borderWidth = 2
       
        btnEditProfile.layer.cornerRadius = 5
        btnEditProfile.layer.borderWidth = 1
        btnEditProfile.layer.borderColor = CColorGray_9B9B9B.cgColor
        //...
        //tblView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        tblView.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsTableViewCell")
        tblView.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "TextNewsTableViewCell")
        
        //...UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        tblView.addSubview(refreshControl)
    }
    
    // MARK: -
    // MARK: - loadData
    
    @objc func pullToRefresh()
    {
        perform(#selector(self.endRefreshing), with: nil, afterDelay: 0.5)
    }
    
    @objc func endRefreshing()
    {
        self.refreshControl.endRefreshing()
    }
    // MARK: -
    // MARK: -  Action Event
    @IBAction func barBtnSettingClicked(_ sender: UIBarButtonItem)
    {
        let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        self.navigationController?.pushViewController(SettingVC, animated: true)
        
    }
    
    @IBAction func btnLikedClicked(sender : UIButton)
    {
        
    }
    @IBAction func btnTagsClicked(sender : UIButton)
    {
        
    }
    @IBAction func btnBookMarkClicked(sender : UIButton)
    {
        
    }
    // MARK: -
    // MARK: - UITable view Data Source and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

            switch indexPath.row
            {
            case 0:
                
                let identifier = "ImageNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
                
                cell.configureCell(data: [:])
                return cell
                
            case 1:
                
                let identifier = "ImageNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
                cell.lblDetails.text = ""
                return cell
                
            case 2:
                
                let identifier = "ImageNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = ""
                cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
                return cell
                
            case 3 :
                
                let identifier = "TextNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
                cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
                
                return cell
                
            case 4 :
                
                let identifier = "TextNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
                cell.lblDetails.text = ""
                return cell
                
            case 5 :
                
                let identifier = "TextNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = ""
                cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
                return cell
                
            default:
                
                let identifier = "ImageNewsTableViewCell"
                let cell = tblView.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
                
                cell.configureCell(data: [:])
                cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
                cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let NewsDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        //        self.present(UINavigationController(rootViewController: NewsDetailsVC), animated: true) {
        //
        //        }
        self.navigationController?.pushViewController(NewsDetailsVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y > 0
        {
           cnHeaderTop.constant = -(scrollView.contentOffset.y)
        }
        else
        {
           cnHeaderTop.constant = 0
        }
        
    }
    
}
