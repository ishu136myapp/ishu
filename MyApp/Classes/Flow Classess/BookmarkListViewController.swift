//
//  BookmarkListViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

enum TagType {
    case BookmarkList
    case TagList
}
class BookmarkListViewController: SuperViewController {
    
    @IBOutlet var tblTag : UITableView!
    var arrBookmark = Array<Any>()
    var tagType : TagType = .BookmarkList
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
        self.title = self.tagType == .BookmarkList ? "Bookmark" : "Tags"
        arrBookmark = [["title":"India",
                        "follower":"10k",
                        "isBookmark":"1"],
                       ["title":"Rajsthan",
                        "follower":"100k",
                        "isBookmark":"0"],
                       ["title":"Pratapgarh",
                        "follower":"45",
                        "isBookmark":"1"],
                       ["title":"ChotiSadri",
                        "follower":"166k",
                        "isBookmark":"0"],
                       ["title":"Bambori",
                        "follower":"12k",
                        "isBookmark":"1"],
                       ["title":"Bharat",
                        "follower":"46k",
                        "isBookmark":"0"],
                       ["title":"Tamilnadu",
                        "follower":"34k",
                        "isBookmark":"0"],
                       ["title":"RajasthanTourism",
                        "follower":"67k",
                        "isBookmark":"0"],
                       ["title":"Cricket",
                        "follower":"1M",
                        "isBookmark":"0"],
                       ["title":"Games",
                        "follower":"500",
                        "isBookmark":"0"],
                       ["title":"U19CricketWorldCup2018",
                        "follower":"780",
                        "isBookmark":"1"],
                       ["title":"Sports",
                        "follower":"23",
                        "isBookmark":"0"],
                       ["title":"AsiaCup2017",
                        "follower":"98",
                        "isBookmark":"0"],
                       ["title":"ChampionsTrophy2017",
                        "follower":"46k",
                        "isBookmark":"0"],
                       ["title":"IPLAuction2018",
                        "follower":"1B",
                        "isBookmark":"0"],
                       ["title":"IndianPremierLeague2018",
                        "follower":"25",
                        "isBookmark":"0"],
                       ["title":"FootballWorldCup",
                        "follower":"100",
                        "isBookmark":"1"]]
        //...
        tblTag.register(UINib(nibName: "TagLineTableViewCell", bundle: nil), forCellReuseIdentifier: "TagLineTableViewCell")
        
    }
    


}

// MARK: -
// MARK: - UITable view data source and delegate

extension BookmarkListViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrBookmark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblTag.dequeueReusableCell(withIdentifier: "TagLineTableViewCell") as! TagLineTableViewCell
        
        
        let dict = arrBookmark[indexPath.row] as! [String : Any]
        cell.lblTitle.text = "#"+dict.valueForString(key: "title")
        cell.lblPeople.text = dict.valueForString(key: "follower") + " People Bookmark"
        cell.btnBookMark.isSelected = !dict.valueForBool(key:"isBookmark")
        cell.btnBookMark.isHidden = self.tagType == .TagList
        cell.btnBookMark .touchUpInside { (sender) in
            
            cell.btnBookMark.isSelected = !cell.btnBookMark.isSelected
            
            var dict = arrBookmark[indexPath.row] as! [String : Any]
            dict.updateValue(cell.btnBookMark.isSelected ? "0":"1", forKey: "isBookmark")
            arrBookmark[indexPath.row] = dict
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = arrBookmark[indexPath.row] as! [String : Any]
        let BookmarkDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "BookmarkDetailsViewController") as! BookmarkDetailsViewController
        BookmarkDetailsVC.CreateUserType = self.tagType == .TagList ? .mine : .Other
        BookmarkDetailsVC.iObject = "#" + dict.valueForString(key: "title")
        self.navigationController?.pushViewController(BookmarkDetailsVC, animated: true)
    }
    
}
