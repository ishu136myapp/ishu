//
//  GenericView.swift
//  Cam4Sell
//
//  Created by Mac-00014 on 16/10/17.
//  Copyright © 2017 Mac-00014. All rights reserved.
//

import UIKit

class GenericView: UIView {
    
    //MARK:-
    //MARK:- Override
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    
    //MARK:-
    //MARK:- Initialize
    
    func initialize() {
        
        if  self.tag == 100 {
            self.layer.cornerRadius = 10
            self.layer.masksToBounds = true
        
        }
        
    }
}
