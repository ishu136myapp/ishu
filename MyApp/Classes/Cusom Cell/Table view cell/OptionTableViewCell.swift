//
//  OptionTableViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 06/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var imgVIcon : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
