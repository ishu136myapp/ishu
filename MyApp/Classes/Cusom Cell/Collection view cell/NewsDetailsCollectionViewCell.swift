//
//  NewsDetailsCollectionViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 27/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class NewsDetailsCollectionViewCell: UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imgVUser : UIImageView!
    @IBOutlet weak var vWimgUser : UIView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblTagline : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblHeadline : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    @IBOutlet weak var btnViews : UIButton!
    @IBOutlet weak var btnLikes : UIButton!
    @IBOutlet weak var btnComment : UIButton!
    @IBOutlet weak var collView : UICollectionView!
    var arrImage : Array<Any>?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgVUser.layer.cornerRadius = imgVUser.CViewWidth / 2
        imgVUser.layer.masksToBounds = true
        
        vWimgUser.layer.cornerRadius = vWimgUser.CViewWidth / 2
        vWimgUser.layer.masksToBounds = true
        vWimgUser.layer.borderColor = CColorTheme_760AFF.cgColor
        vWimgUser.layer.borderWidth = 2
        
        collView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }

    // MARK: -
    // MARK: - Configure cell
    
    func configureCell(data:[String : Any])
    {
        
        arrImage = ["ajinkya-rahane_.jpg","ishu.jpg","ishu.jpg"]
        self.collView.reloadData()
        self.btnLikes.touchUpInside { (sender) in
            sender.isSelected = !sender.isSelected
        }
    }
    
    // MARK: -
    // MARK: - Collection view data source and delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrImage?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: CScreenWidth, height: (211/375)*CScreenWidth)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.imgV.image = UIImage(named: (arrImage?[indexPath.row] as! String))
        return cell
    }
}
