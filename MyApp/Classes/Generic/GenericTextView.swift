//
//  GenericTextView.swift
//  Cam4Sell
//
//  Created by Mac-00014 on 16/10/17.
//  Copyright © 2017 Mac-00014. All rights reserved.
//

import UIKit

class GenericTextView: UITextView {

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.initialize()
    }
    
     // MARK:
    // MARK: initialize
    
    func initialize()
    {
        self.delegate = self
    
    
        if self.tag == 100
        {
            self.backgroundColor = CColorGray_EEEEEE
            self.textContainerInset.top = 15
            self.textContainerInset.left = 15
            self.textContainerInset.right = 15
            self.textContainerInset.bottom = 15
        }
    }
    
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
         self.resizePlaceholder()
        
    }
    /// The UITextView placeholder text
    override var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(101) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(101) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public override func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(101) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(101) as! UILabel?
        {
            var labelX = self.textContainerInset.left + 3
            var labelWidth = self.frame.width - (labelX * 2)
            let labelY = self.textContainerInset.top - 2
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width:labelWidth , height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 101
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    

}
