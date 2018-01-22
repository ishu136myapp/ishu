//
//  HomeViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class HomeViewController: SuperViewController,UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var tblFeed : UITableView!
    
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
        
        tblFeed.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsTableViewCell")
    }
    
    // MARK: -
    // MARK: - Action Event
    
    
    // MARK: -
    // MARK: - UITable view Data Source and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "ImageNewsTableViewCell"
        let cell = tblFeed.dequeueReusableCell(withIdentifier: identifier) as! ImageNewsTableViewCell
        
        return cell
    }
}
