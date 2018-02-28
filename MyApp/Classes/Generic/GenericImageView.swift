//
//  GenericImageView.swift
//  Cam4Sell
//
//  Created by Mac-00014 on 16/10/17.
//  Copyright © 2017 Mac-00014. All rights reserved.
//

import UIKit

class GenericImageView: UIImageView {
    
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
        
        if self.tag == 100 {
            
            self.layer.borderWidth = 1
            self.layer.borderColor = CColorGray_E3E3E3.cgColor
            self.layer.cornerRadius = self.CViewWidth / 2
            self.layer.masksToBounds = true;
        }
        
    }
    
    
    //MARK:-
    //MARK:- Initialize
    
    func initialize() {
        
        
    }
    
}
