//
//  SearchNewsCollectionViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 04/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class SearchNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vWContent : UIView!
    @IBOutlet weak var lblHeadline : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        vWContent.layer.cornerRadius =  2
//        vWContent.layer.masksToBounds = true
//        vWContent.layer.borderColor = CColorGray_B2B2B2.cgColor
//        vWContent.layer.borderWidth = 1
    }
}
