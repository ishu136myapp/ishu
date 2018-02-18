//
//  TapableLabel.swift
//  MyApp
//
//  Created by ishwar lal janwa on 13/02/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

typealias ClosureCompletion = (_ details:Any?) -> Void

class TapableLabel: UILabel
{
    var ClosureCompletion : ClosureCompletion?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:
    // MARK: initialize
    
    func initialize()
    {
        self.textColor = CColorBlue_007AFF
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    func configureHashTag(HashTag:Array<[String:Any]>?, complition:ClosureCompletion?)
    {
        ClosureCompletion = complition

    }
    
    @objc func didTap(gesture: UITapGestureRecognizer)
    {
        if (self.ClosureCompletion != nil)
        {
            self.ClosureCompletion!(["tap":"clicked"])
        }
    }
}
