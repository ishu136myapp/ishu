//
//  SuperViewController.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import UIKit

enum StopAnimationType : Int {
    case dataNotFound
    case errorTapToRetry
    case remove
}
class SuperViewController: UIViewController {
    
    var iObject : Any!
    var touchUpInsideViewClicked: (() -> Void)? = nil
    @IBOutlet var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.resignKeyboard()
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK:  -
    // MARK: - General Method
    
    func configureNavigationBar()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        
        //.....Generic config of UINavigationBar.....
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let image = UIImage(named: "arrow_back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationController?.navigationBar.backIndicatorImage = image
        
        self.navigationController?.navigationBar.titleTextAttributes = [.font: CFontRoboto(size: 16, type: .Medium), .foregroundColor: CColorWhite_FFFFFF]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = CColorTheme_760AFF

        self.navigationController?.navigationBar.tintColor = CColorTheme_760AFF
        self.navigationController?.navigationBar.isHidden = false
        if self.view.tag == 100
        {
            self.navigationController?.navigationBar.isTranslucent = true
           // self.navigationController?.navigationBar.barTintColor = CRGBA(r: 0, g: 0, b: 0, a: 0.1)
            self.navigationController?.navigationBar.isHidden = true
        }
        
    }
    
    func configureSearchBar()
    {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField
        {
            textfield.textColor = UIColor.black
            textfield.font = CFontRoboto(size: 15, type: .Regular)
            if let backgroundview = textfield.subviews.first
            {
                // Rounded corner
                backgroundview.layer.cornerRadius = 18
                backgroundview.clipsToBounds = true
            }
        }
    }
    func resignKeyboard()
    {
        UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @IBAction func btnBackClicked(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:  -
    // MARK: - Helper Method
    
    func startLoadingAnimation(in view: UIView)
    {
        
        var animationView = view.viewWithTag(1000)
        if animationView == nil {
            animationView = UIView(frame: CGRect.zero)
            animationView?.translatesAutoresizingMaskIntoConstraints = false
            animationView?.backgroundColor = UIColor.white
            animationView?.tag = 1000
            //....
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.color = CColorRed_D0021B
            activityIndicator.hidesWhenStopped = true
            activityIndicator.center = animationView?.center ?? CGPoint.zero
            activityIndicator.startAnimating()
            activityIndicator.tag = 1001
            animationView?.addSubview(activityIndicator)
            animationView?.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: animationView, attribute: .centerX, multiplier: 1, constant: 0))
            animationView?.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: animationView, attribute: .centerY, multiplier: 1, constant: 0))
            //....
            view.addSubview(animationView!)
            view.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
            
        }
        else {
            //...
            let activityIndicator = animationView?.viewWithTag(1001) as? UIActivityIndicatorView
            if activityIndicator != nil {
                activityIndicator?.startAnimating()
            }
            //...
            let imageView = animationView?.viewWithTag(1002) as? UIImageView
            if imageView != nil {
                imageView?.isHidden = true
            }
            //...
            let lblTitle = animationView?.viewWithTag(1003) as? UILabel
            if lblTitle != nil {
                lblTitle?.isHidden = true
            }
        }
    }
    
    func stopLoadingAnimation(in view: UIView, type stopAnimationType: StopAnimationType, touchUpInsideClickedEvent completion: @escaping () -> Void)
    {
        let animationView = view.viewWithTag(1000)
        if animationView != nil
        {
            if stopAnimationType == StopAnimationType.remove
            {
                animationView?.removeFromSuperview()
            }
            else
            {
                //...
                let activityIndicator = view.viewWithTag(1001) as? UIActivityIndicatorView
                if activityIndicator != nil {
                    activityIndicator?.stopAnimating()
                }
                var imageView = animationView?.viewWithTag(1002) as? UIImageView
                //...
                if imageView == nil {
                    //...
                    imageView = UIImageView(frame: CGRect.zero)
                    imageView?.translatesAutoresizingMaskIntoConstraints = false
                    imageView?.tag = 1002
                    animationView?.addSubview(imageView ?? UIView())
                    animationView?.addConstraint(NSLayoutConstraint(item: imageView ?? UIImageView(), attribute: .centerX, relatedBy: .equal, toItem: animationView, attribute: .centerX, multiplier: 1, constant: 0))
                    animationView?.addConstraint(NSLayoutConstraint(item: imageView ?? UIImageView(), attribute: .centerY, relatedBy: .equal, toItem: animationView, attribute: .centerY, multiplier: 0.75, constant: 0))
                }
                else {
                    imageView?.isHidden = false
                }
                //...
                var lblTitle = animationView?.viewWithTag(1003) as? UILabel
                if lblTitle == nil {
                    lblTitle = UILabel(frame: CGRect.zero)
                    lblTitle?.translatesAutoresizingMaskIntoConstraints = false
                    lblTitle?.tag = 1003
                    lblTitle?.textColor = CColorRed_D0021B
                    lblTitle?.font = CFontRoboto(size: 20, type: .Regular)
                    lblTitle?.textAlignment = .center
                    lblTitle?.numberOfLines = 0
                    animationView?.addSubview(lblTitle ?? UIView())
                    animationView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .left, relatedBy: .equal, toItem: animationView, attribute: .left, multiplier: 1, constant: 12))
                    animationView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .right, relatedBy: .equal, toItem: animationView, attribute: .right, multiplier: 1, constant: -12))
                    animationView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 16))
                }
                else {
                    lblTitle?.isHidden = false
                }
                switch stopAnimationType {
                case .dataNotFound:
                    imageView?.image = UIImage(named: "nofeed")
                    lblTitle?.text = CMessageNoResultFound
                    animationView?.isUserInteractionEnabled =  false
                case .errorTapToRetry:
                    imageView?.image = UIImage(named: "worried")
                    lblTitle?.text = CErrorTapToRetry
                    touchUpInsideViewClicked = completion
                    animationView?.isUserInteractionEnabled =  true
                    
                    guard (animationView?.gestureRecognizers) != nil else {
                        
                        animationView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapGestureRecognizer)))
                        break
                    }
                    
                    
                    
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func tapGestureRecognizer(_ tapGesture: UITapGestureRecognizer)
    {
        if (touchUpInsideViewClicked != nil) {
            touchUpInsideViewClicked!()
        }
    }
    
    
    
    func startLoadMoreAnimation(in view: UIView)
    {
        
        var activityIndicator = (self.view.viewWithTag(3001) as? UIActivityIndicatorView)
        if activityIndicator == nil
        {
            //....
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator!.color = CColorRed_D0021B
            activityIndicator!.hidesWhenStopped = true
            activityIndicator!.center = self.view?.center ?? CGPoint.zero
            activityIndicator!.startAnimating()
            activityIndicator!.tag = 3001
            self.view?.addSubview(activityIndicator!)
            self.view?.addConstraint(NSLayoutConstraint(item: activityIndicator!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: activityIndicator!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -8))
            
            
        }
        else {
            
            let activityIndicator = self.view?.viewWithTag(3001) as? UIActivityIndicatorView
            if activityIndicator != nil {
                activityIndicator?.startAnimating()
            }
            
        }
    }
    
    func stopLoadMoreAnimation(in view: UIView)
    {
        
        let activityIndicator = (self.view.viewWithTag(3001) as? UIActivityIndicatorView)
        if activityIndicator != nil
        {
            //....
            activityIndicator?.removeFromSuperview()
            
            
        }
        
        
    }
    func showNoDataFound(in view: UIView) {
        var noDataView = view.viewWithTag(2000)
        if noDataView == nil {
            noDataView = UIView(frame: CGRect.zero)
            noDataView?.translatesAutoresizingMaskIntoConstraints = false
            noDataView?.backgroundColor = UIColor.white
            noDataView?.tag = 2000
            //....
            view.addSubview(noDataView ?? UIView())
            view.addConstraint(NSLayoutConstraint(item: noDataView ?? UIView(), attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: noDataView ?? UIView(), attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: noDataView ?? UIView(), attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: noDataView ?? UIView(), attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
            var imageView = noDataView?.viewWithTag(2002) as? UIImageView
            //...
            if imageView == nil {
                //...
                imageView = UIImageView(frame: CGRect.zero)
                imageView?.translatesAutoresizingMaskIntoConstraints = false
                imageView?.tag = 2002
                noDataView?.addSubview(imageView ?? UIView())
                noDataView?.addConstraint(NSLayoutConstraint(item: imageView ?? UIImageView(), attribute: .centerX, relatedBy: .equal, toItem: noDataView, attribute: .centerX, multiplier: 1, constant: 0))
                noDataView?.addConstraint(NSLayoutConstraint(item: imageView ?? UIImageView(), attribute: .centerY, relatedBy: .equal, toItem: noDataView, attribute: .centerY, multiplier: 0.75, constant: 0))
            }
            //...
            var lblTitle = noDataView?.viewWithTag(2003) as? UILabel
            if lblTitle == nil {
                lblTitle = UILabel(frame: CGRect.zero)
                lblTitle?.translatesAutoresizingMaskIntoConstraints = false
                lblTitle?.tag = 2003
                lblTitle?.textColor = CColorRed_D0021B
                lblTitle?.font = CFontRoboto(size: 20, type: .Regular)
                lblTitle?.textAlignment = .center
                lblTitle?.numberOfLines = 0
                noDataView?.addSubview(lblTitle ?? UIView())
                noDataView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .left, relatedBy: .equal, toItem: noDataView, attribute: .left, multiplier: 1, constant: 12))
                noDataView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .right, relatedBy: .equal, toItem: noDataView, attribute: .right, multiplier: 1, constant: -12))
                noDataView?.addConstraint(NSLayoutConstraint(item: lblTitle ?? UILabel(), attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 16))
            }
            imageView?.image = UIImage(named: "nofeed")
            lblTitle?.text = CMessageNoResultFound
        }
    }
    
    func removeNodataFound(in view: UIView)
    {
        let noDataView = view.viewWithTag(2000)
        if noDataView != nil {
            noDataView?.removeFromSuperview()
        }
    }
    
}
