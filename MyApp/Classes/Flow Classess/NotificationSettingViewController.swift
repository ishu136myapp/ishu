//
//  NotificationSettingViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 27/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class NotificationSettingViewController: SuperViewController {

    @IBOutlet var tblBookmark : UITableView!
    var arrBookmark = Array<Any>()
    
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
        self.title = "Notification Setting"
        arrBookmark = [["title":"India",
                        "follower":"10k",
                        "isAllow":"1"],
                       ["title":"Rajsthan",
                        "follower":"100k",
                        "isAllow":"0"],
                       ["title":"Pratapgarh",
                        "follower":"45",
                        "isAllow":"1"],
                       ["title":"ChotiSadri",
                        "follower":"166k",
                        "isAllow":"0"],
                       ["title":"Bambori",
                        "follower":"12k",
                        "isAllow":"1"],
                       ["title":"Bharat",
                        "follower":"46k",
                        "isAllow":"0"],
                       ["title":"Tamilnadu",
                        "follower":"34k",
                        "isAllow":"0"],
                       ["title":"RajasthanTourism",
                        "follower":"67k",
                        "isAllow":"0"],
                       ["title":"Cricket",
                        "follower":"1M",
                        "isAllow":"0"],
                       ["title":"Games",
                        "follower":"500",
                        "isAllow":"0"],
                       ["title":"U19CricketWorldCup2018",
                        "follower":"780",
                        "isAllow":"1"],
                       ["title":"Sports",
                        "follower":"23",
                        "isAllow":"0"],
                       ["title":"AsiaCup2017",
                        "follower":"98",
                        "isAllow":"0"],
                       ["title":"ChampionsTrophy2017",
                        "follower":"46k",
                        "isAllow":"0"],
                       ["title":"IPLAuction2018",
                        "follower":"1B",
                        "isAllow":"0"],
                       ["title":"IndianPremierLeague2018",
                        "follower":"25",
                        "isAllow":"0"],
                       ["title":"FootballWorldCup",
                        "follower":"100",
                        "isAllow":"1"]]
    
    }
    
}

// MARK: -
// MARK: - UITable view data source and delegate

extension NotificationSettingViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrBookmark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSettingTableViewCell") as! NotificationSettingTableViewCell
        
        
        let dict = arrBookmark[indexPath.row] as! [String : Any]
        cell.lblTitle.text = "#"+dict.valueForString(key: "title")
        cell.swtch.isOn = dict.valueForBool(key: "isAllow")
        
        return cell
    }
    
}
