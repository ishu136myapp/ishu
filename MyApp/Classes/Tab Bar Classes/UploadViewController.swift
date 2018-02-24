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
    @IBOutlet var txtSelectHashtag: UITextField!
    
    @IBOutlet var collHashTag: UICollectionView!
    @IBOutlet var collVImage: UICollectionView!
    @IBOutlet var tblSuggesstion: UITableView!
    
    @IBOutlet var cnNextLeading: NSLayoutConstraint!
    @IBOutlet var cnVStep1Leading: NSLayoutConstraint!
    @IBOutlet var cnCollHashtagHeight: NSLayoutConstraint!
    @IBOutlet var cnCollImageHeight: NSLayoutConstraint!
    var arrSuggesstion = [Any]()
    var arrSelectedHashTag = [String]()
    var arrSelectedImages = [Any]()
    
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
                btnNext.isSelected = arrSelectedHashTag.count > 0
                txtVTitle.resignFirstResponder()
                txtVDescription.resignFirstResponder()
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
                self.presentAlertViewWithTwoButtons(alertTitle: "", alertMessage: "You are about to publish this update online. Continue?", btnOneTitle: "NO", btnOneTapped: { (action) in
                    
                }, btnTwoTitle: "YES", btnTwoTapped: { (action) in
                    
                    if let navigation = appDelegate?.tabbarController?.viewControllers![0] as? UINavigationController
                    {
                        navigation.popToRootViewController(animated: false)
                        appDelegate?.tabbarController?.selectedIndex = 0
                        
                    }
                    
                    self.txtVTitle.text = ""
                    self.txtVDescription.text = ""
                    self.arrSelectedHashTag.removeAll()
                    self.collHashTag.reloadData()
                    self.arrSelectedImages.removeAll()
                    self.collVImage.reloadData()
                    self.collVImage.performBatchUpdates(nil, completion: { (complete) in
                        self.cnCollImageHeight.constant = self.collVImage.contentSize.height
                    })
                    self.cnVStep1Leading.constant = 0
                    self.cnNextLeading.constant = -(self.btnNext.CViewWidth/2)
                    self.view.layoutIfNeeded()
                    self.btnPrevious.isHidden = true
                    self.txtVTitle.placeholder = "Title"
                    self.txtVDescription.placeholder = "Description"
                    self.currentStep = 1
                    self.btnNext.isSelected = false
                })
                
            }
        default:
            break
        }
        
        
    }
    
    @IBAction func btnPreviousClicked(_ sender: UIButton)
    {
        switch currentStep
        {
        case 2:
            btnNext.isSelected = true
            UIView.animate(withDuration: 0.3, animations: {
            
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
    
    @IBAction func textChangedEvent(_ sender: UITextField)
    {
        if !(sender.text?.isBlank)!
        {
            arrSuggesstion = ["India","Rajasthan","Pratapgarh","ChhotiSadri","Bambori"]
            tblSuggesstion.isHidden = false
            tblSuggesstion.reloadData()
        }
        else
        {
            tblSuggesstion.reloadData()
            tblSuggesstion.isHidden = true
        }
        
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
        let strHashTag = "#\(arrSelectedHashTag[indexPath.row])"
        var size = strHashTag.size(withAttributes: [NSAttributedStringKey.font : CFontRoboto(size: 15, type: .Regular)])
        size.height = 32
        size.width = size.width + 46
        
        if (size.width > collectionView.CViewWidth)
        {
            size.width = collectionView.CViewWidth
        }
        return size
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == collHashTag
        {
            return arrSelectedHashTag.count
        }
        return arrSelectedImages.count < 4 ? arrSelectedImages.count + 1 : arrSelectedImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collHashTag
        {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "BubbleCollectionViewCell", for: indexPath) as! BubbleCollectionViewCell
            if let hashtag = arrSelectedHashTag[indexPath.row] as? String
            {
                cell.lblTitle.text = "#\(hashtag)"
            }
            
            cell.btnCancle.touchUpInside(genericTouchUpInsideHandler: { (sender) in
                
                arrSelectedHashTag.remove(at: indexPath.row)
                collHashTag.reloadData()
                collHashTag.performBatchUpdates(nil)
                { (complete) in
                    
                    self.cnCollHashtagHeight.constant = self.collHashTag.contentSize.height
                }
                
                self.btnNext.isSelected = self.arrSelectedHashTag.count > 0
            })
            return cell
        }
        else
        {
            
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell

             if indexPath.row < arrSelectedImages.count
            {
                cell.btnClose.isHidden = false;
                cell.imgV.image = arrSelectedImages[indexPath.row] as? UIImage
                cell.imgV.contentMode = .scaleAspectFill
                cell.imgV.layer.borderWidth = 0;
                cell.btnClose.touchUpInside(genericTouchUpInsideHandler: { (sender) in
                    
                    self.presentAlertViewWithTwoButtons(alertTitle: "", alertMessage: "Are you sure you want to remove the image?", btnOneTitle: "NO", btnOneTapped: { (action) in
                        
                    }, btnTwoTitle: "YES", btnTwoTapped: { (action) in
                     
                        self.arrSelectedImages.remove(at: indexPath.row)
                        self.collVImage.reloadData()
                        self.collVImage.performBatchUpdates(nil, completion: { (complete) in
                            self.cnCollImageHeight.constant = self.collVImage.contentSize.height
                        })
                    })
                    
                })
            }
            else
             {
                cell.btnClose.isHidden = true;
                cell.imgV.image = UIImage(named: "camera")
                cell.imgV.contentMode = .center
                cell.imgV.layer.borderWidth = 1;
                cell.imgV.layer.borderColor = CColorGray_B2B2B2.cgColor
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView ==  collVImage && indexPath.row > arrSelectedImages.count - 1
        {
            self.presentImagePickerController(allowEditing: false, imagePickerControllerCompletionHandler: { (image
                , dict) in
                
                let cropVC = self.storyboard?.instantiateViewController(withIdentifier: "CropImageViewController") as! CropImageViewController
                cropVC.originalImage = image
                cropVC .setBlock(block: { (editedImage, error) in
                    
                    self.arrSelectedImages.append(editedImage!)
                    self.collVImage.reloadData()
                    self.collVImage.performBatchUpdates(nil, completion: { (complete) in
                        self.cnCollImageHeight.constant = self.collVImage.contentSize.height
                    })
                })
                self.present(cropVC, animated: true, completion: {
                    
                })
            })
        }
    }
}

// MARK: -
// MARK: - UITable view delegate and data source
extension UploadViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSuggesstion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblSuggesstion.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell") as! SuggesstionTableViewCell
        
        if let hashtag = arrSuggesstion[indexPath.row] as? String
        {
            cell.lblTitle.text = "#\(hashtag)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let hashtag = arrSuggesstion[indexPath.row] as? String
        {
            if !arrSelectedHashTag.contains("\(hashtag)" )
            {
                arrSelectedHashTag.append(hashtag)
                collHashTag.reloadData()
                collHashTag.performBatchUpdates(nil)
                { (complete) in
                    
                    self.cnCollHashtagHeight.constant = self.collHashTag.contentSize.height
                }
            }
            
        }
        self.btnNext.isSelected = self.arrSelectedHashTag.count > 0
        txtSelectHashtag.text = ""
        tblSuggesstion.isHidden = true
    }
}
