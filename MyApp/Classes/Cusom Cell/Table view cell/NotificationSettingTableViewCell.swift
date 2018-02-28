//
//  NotificationSettingTableViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 27/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class NotificationSettingTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var swtch : UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
