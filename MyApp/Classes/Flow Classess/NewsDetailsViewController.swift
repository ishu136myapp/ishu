//
//  NewsDetailsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class NewsDetailsViewController: SuperViewController {

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
        self.title = "News Details"
    }

}
