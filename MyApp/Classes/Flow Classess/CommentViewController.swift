//
//  CommentViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 28/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class CommentViewController: SuperViewController {

    @IBOutlet var vWFooter : UIView!
    @IBOutlet var vWBackground : UIView!
    @IBOutlet var txtcomment : UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initialize()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    func initialize() {
        
        vWBackground.layer.cornerRadius = 10
        vWBackground.layer.masksToBounds = true
        vWFooter.layer.borderWidth = 1
        vWFooter.layer.borderColor = CColorGray_E3E3E3.cgColor
        txtcomment.layer.borderWidth = 1
        txtcomment.layer.borderColor = CColorGray_E3E3E3.cgColor
        txtcomment.layer.cornerRadius = txtcomment.CViewHeight / 2
        txtcomment.layer.masksToBounds = true
        txtcomment.addLeftImageAsLeftView(strImgName: "", leftPadding: 16)
        txtcomment.addRightImageAsRightView(strImgName: "send_comment", rightPadding: 20)
        
    }
}

extension CommentViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableviewcell") as! UITableViewCell
        return cell
    }
    
    
}
