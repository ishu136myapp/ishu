//
//  TextNewsTableViewCell.swift
//  MyApp
//
//  Created by ishwar lal janwa on 27/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class TextNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVUser : UIImageView!
    @IBOutlet weak var vWimgUser : UIView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblTagline : ActiveLabel!
    @IBOutlet weak var lblHeadline : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    @IBOutlet weak var btnViews : UIButton!
    @IBOutlet weak var btnLikes : UIButton!
    @IBOutlet weak var btnComment : UIButton!
    @IBOutlet weak var btnProfile : UIButton!
    @IBOutlet weak var btnOption : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgVUser.layer.cornerRadius = imgVUser.CViewWidth / 2
        imgVUser.layer.masksToBounds = true
        
        vWimgUser.layer.cornerRadius = vWimgUser.CViewWidth / 2
        vWimgUser.layer.masksToBounds = true
        vWimgUser.layer.borderColor = CColorTheme_760AFF.cgColor
        vWimgUser.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: -
    // MARK: - Configure cell
    
    func configureCell(data:[String : Any])
    {
        self.btnLikes.touchUpInside { (sender) in
            sender.isSelected = !sender.isSelected
        }
        
        self.btnProfile.touchUpInside { (sender) in
            
            if let AccountVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
            {
                AccountVC.accountType = .Profile; self.viewController?.navigationController?.pushViewController(AccountVC, animated: true)
                
            }
        }
        self.btnOption.touchUpInside(genericTouchUpInsideHandler: { (sender) in
            
            var  option  = UIView()
             option  = OptionView.OptionViewWithHandler(optionType: .OtherUserPost, handler: { (Index, title) in
                
                
                self.viewController?.dismissPopUp(view: option, completionHandler: {
                    
                })
            })
            self.viewController?.presentPopUp(view: option, shouldOutSideClick: true, type: .bottom, completionHandler: {
                
            })
        })
        
        self.lblTagline.hashtagColor = CColorBlue_007AFF
        self.lblTagline.handleHashtagTap { (tapString) in
            
            print(tapString)
            self.lblTagline.handleHashtagTap { (tapString) in
                
                print(tapString)
                let BookmarkDetailsVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "BookmarkDetailsViewController") as! BookmarkDetailsViewController
                BookmarkDetailsVC.iObject = "#" + tapString
                self.viewController?.navigationController?.pushViewController(BookmarkDetailsVC, animated: true)
            }
        }
    }
}
