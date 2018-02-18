//
//  BubbleCollectionViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 15/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class BubbleCollectionViewCell: UICollectionViewCell
{
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var btnCancle : UIButton!
    @IBOutlet var vWContent : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vWContent.layer.cornerRadius = vWContent.CViewHeight/2
    }

}
