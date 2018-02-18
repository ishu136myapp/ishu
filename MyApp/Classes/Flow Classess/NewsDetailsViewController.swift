//
//  NewsDetailsViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class NewsDetailsViewController: SuperViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var vWNavigation : UIView!
    @IBOutlet var collView : UICollectionView!
    
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
       // self.title = "News Details"
       vWNavigation.backgroundColor =  CRGBA(r: 0, g: 0, b: 0, a: 0.3)
    }

    // MARK: -
    // MARK: - Action Event
    
    @IBAction func btnOptionClicked(_ sender: UIButton)
    {
        
        var  option  = UIView()
        option  = OptionView.OptionViewWithHandler(optionType: .OtherUserPost, handler: { (Index, title) in
            self.dismissPopUp(view: option, completionHandler: {
            })
        })
        self.presentPopUp(view: option, shouldOutSideClick: true, type: .bottom, completionHandler: {
            
        })
        
    }
    
    
    // MARK: -
    // MARK: - Collection view data source and delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: CScreenWidth, height: collView.CViewHeight)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "NewsDetailsCollectionViewCell", for: indexPath) as! NewsDetailsCollectionViewCell
        
        cell.configureCell(data: [:])
        return cell
    }
}
