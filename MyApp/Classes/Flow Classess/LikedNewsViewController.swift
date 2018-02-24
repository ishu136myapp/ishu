//
//  LikedNewsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class LikedNewsViewController: SuperViewController {
    
    
    @IBOutlet var tblLiked : UITableView!
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
        self.title = "Liked"
        
        tblLiked.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsTableViewCell")
        tblLiked.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "TextNewsTableViewCell")
    }
    
    // MARK: -
    // MARK: - loadData
    
    // MARK: -
    // MARK: - Action Event
    
    
}

// MARK: -
// MARK: - UITable view Data Source and Delegate

extension LikedNewsViewController : UITableViewDelegate, UITableViewDataSource
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
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            
            return cell
            
        case 1:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = ""
            return cell
            
        case 2:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = ""
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
            
        case 3 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            
            return cell
            
        case 4 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = ""
            return cell
            
        case 5 :
            
            let identifier = "TextNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! TextNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = ""
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
            
        default:
            
            let identifier = "ImageNewsTableViewCell"
            let cell = tblLiked.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
            
            cell.configureCell(data: [:])
            cell.lblHeadline.text = "Ravi Shastri defends Ajinkya Rahane's omission from first two Tests"
            cell.lblDetails.text = "JOHANNESBURG: India coach Ravi Shastri on Monday defended the team management's decision to leave out Ajinkya Rahane from the first two Tests in South Africa, saying Rohit Sharma was the best option going by form.One of the most successful Indian batsmen overseas in recent years, vice-captain Rahane was not picked for the Tests in Cape Town and Centurion, with the Indian team management preferring to go with limited-overs specialist Sharma on current form."
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let NewsDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        self.present(UINavigationController(rootViewController: NewsDetailsVC), animated: true) {
        }
    }
}

