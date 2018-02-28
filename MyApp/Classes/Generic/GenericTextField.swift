//
//  GenericTextField.swift
//  Cam4Sell
//
//  Created by Mac-00014 on 16/10/17.
//  Copyright © 2017 Mac-00014. All rights reserved.
//

import UIKit

class GenericTextField: UITextField {
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:
    // MARK: initialize
    
    func initialize()
    {
            
        self.autocorrectionType = .no
        
        //self.font = UIFont(name: (self.font?.fontName)!, size: IS_iPhone_5 ? (self.font?.pointSize)! - 2 : (self.font?.pointSize)!)
    }

}

