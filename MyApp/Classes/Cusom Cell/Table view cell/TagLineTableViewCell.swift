//
//  TagLineTableViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 30/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class TagLineTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblPeople : UILabel!
    @IBOutlet var btnBookMark : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
