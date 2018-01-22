//
//  ImageNewsTableViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 22/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class ImageNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVUser : UIImageView!
    @IBOutlet weak var vWimgUser : UIView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblTagline : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    @IBOutlet weak var btnViews : UIButton!
    @IBOutlet weak var btnLikes : UIButton!
    @IBOutlet weak var btnComment : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgVUser.layer.cornerRadius = 21//CViewWidth(imgVUser) / 2
        imgVUser.layer.masksToBounds = true
        
        vWimgUser.layer.cornerRadius = 25//CViewWidth(imgVUser) / 2
        vWimgUser.layer.masksToBounds = true
        vWimgUser.layer.borderColor = CColorTheme_760AFF.cgColor
        vWimgUser.layer.borderWidth = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
