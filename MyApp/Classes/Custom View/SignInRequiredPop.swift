//
//  SignInRequiredPop.swift
//  MyApp
//
//  Created by ishwar lal janwa on 24/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class SignInRequiredPop: UIView {
    var optionHandler : optionHandler?

    class func alertViewWithHandler(handler : optionHandler?) -> SignInRequiredPop
    {
        let signInRequiredVW = Bundle.main.loadNibNamed("SignInRequiredPop", owner: nil, options: nil)![0] as? SignInRequiredPop
        signInRequiredVW?.optionHandler = handler
        signInRequiredVW?.CViewSetWidth(width: 252)
        signInRequiredVW?.CViewSetHeight(height: 287)
        signInRequiredVW?.layer.cornerRadius = 5
        signInRequiredVW?.layer.masksToBounds = true
        return signInRequiredVW!
    }
    
    
    @IBAction func btnClicked(_ sender : UIButton)
    {
        if self.optionHandler != nil
        {
            self.optionHandler!(sender.tag, sender.titleLabel?.text)
        }
    }
    
}
