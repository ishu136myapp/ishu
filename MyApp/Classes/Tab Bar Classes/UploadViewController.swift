//
//  UploadViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

class UploadViewController: SuperViewController {

    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    
    @IBOutlet var vWselectHashtag: UIView!
    
    @IBOutlet var txtVTitle: UITextView!
    @IBOutlet var txtVDescription: UITextView!
    
    @IBOutlet var collHashTag: UICollectionView!
    @IBOutlet var collVImage: UICollectionView!
    
    @IBOutlet var cnNextLeading: NSLayoutConstraint!
    @IBOutlet var cnVStep1Leading: NSLayoutConstraint!
    @IBOutlet var cnCollHashtagHeight: NSLayoutConstraint!
    
    var currentStep : Int = 1
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    func initialize()
    {
        //...
        self.txtVTitle.delegate = self
        self.txtVDescription.delegate = self
        self.cnVStep1Leading.constant = 0
        
        let bubble = CollectionViewBubbleLayout()
        collHashTag.setCollectionViewLayout(bubble, animated: false)
        bubble.delegate = self
        bubble.minimumLineSpacing = 8
        bubble.minimumInteritemSpacing = 8;
        
        collHashTag.performBatchUpdates(nil)
        { (complete) in
            
            self.cnCollHashtagHeight.constant = self.collHashTag.contentSize.height
        }
        
    }
    
    // MARK: -
    // MARK: - Action Event
    @IBAction func btnNextClicked(_ sender: UIButton)
    {
        switch currentStep
        {
        case 1:
            if btnNext.isSelected // For Scroll to step 2
            {
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.cnVStep1Leading.constant = -CScreenWidth
                    self.cnNextLeading.constant = 8
                    self.view.layoutIfNeeded()
                    self.btnPrevious.isHidden = false
                })
                currentStep = 2
                btnNext.isSelected = false
            }
            else // if title and description is blank
            {
                
            }
        case 2:
            if btnNext.isSelected // scroll to step 3
            {
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.cnVStep1Leading.constant = -CScreenWidth*2
                    self.view.layoutIfNeeded()
                })
                currentStep = 3
            }
            else // if Hashtag is not selected
            {
                
            }
        case 3:
            if btnNext.isSelected // Upload news
            {
                
            }
            else // if Hashtag is not selected
            {
                
            }
        default:
            break
        }
        
        
    }
    
    @IBAction func btnPreviousClicked(_ sender: UIButton)
    {
        switch currentStep
        {
        case 2: UIView.animate(withDuration: 0.3, animations: {
            
            self.cnVStep1Leading.constant = 0
            self.cnNextLeading.constant = -(self.btnNext.CViewWidth/2)
            self.view.layoutIfNeeded()
            self.btnPrevious.isHidden = true
        })
            currentStep = 1
        case 3:
            UIView.animate(withDuration: 0.3, animations: {
             
                self.cnVStep1Leading.constant = -CScreenWidth
                self.view.layoutIfNeeded()
            })
            currentStep = 2
        default:
            break
            
        }
    }

    @IBAction func btnSelectHashTagClicked(_ sender: UIButton)
    {
        
    }
}
// MARK: -
// MARK: - UITextViewDelegate
extension UploadViewController : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        if textView == txtVTitle
        {
            txtVTitle.placeholder = txtVTitle.text.isBlank ? "Title" : ""
        }
        else
        {
            txtVDescription.placeholder = txtVDescription.text.isBlank ? "Description" : ""
        }
        
        btnNext.isSelected = !txtVDescription.text.isBlank || !txtVTitle.text.isBlank
        
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        switch textView
        {
        case txtVTitle:
            let currentText = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)
            
            return updatedText.count <= 200
            
            
            
        default:
            return true
        }
    }
}

// MARK: -
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

extension UploadViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionViewBubbleLayoutDelegate
{
    func collectionView(collectionView: UICollectionView, itemSizeAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let strHashTag = "#Rajasthan"
        var size = strHashTag.size(withAttributes: [NSAttributedStringKey.font : CFontRoboto(size: 14, type: .Regular)])
        size.height = 32
        size.width = size.width + 46
        
        if (size.width > collectionView.CViewWidth)
        {
            size.width = collectionView.CViewWidth
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
      return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collHashTag
        {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "BubbleCollectionViewCell", for: indexPath) as! BubbleCollectionViewCell
            cell.lblTitle.text = "#Rajasthan"
            return cell
        }
        else
        {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == collVImage
        {
          return CGSize(width: (CScreenWidth - 42)/2, height: 0.5625 * ((CScreenWidth - 42)/2))
        }
        else
        {
          return CGSize.zero
        }
        
        
    }
    
}
