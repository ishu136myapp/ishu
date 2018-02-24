//
//  CropImageViewController.swift
//  ImageCropper
//
//  Created by Mac-00014 on 24/01/18.
//  Copyright © 2018 Mac-00014. All rights reserved.
//

import UIKit

let SCALE_FRAME_Y  = 100.0
let BOUNDCE_DURATION = 0.3
let LimitRatio     = 3.0


class CropImageViewController: UIViewController {

    var originalImage : UIImage?
    
    @IBOutlet var imgVPhoto : UIImageView!
    
    @IBOutlet var viewOverlay : UIView!
    
    @IBOutlet var viewCropper : UIView!

    var minFrame : CGRect!
    var maxFrame : CGRect!
    var currentFrame : CGRect!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: - General Method
    
    func initialize()
    {
        imgVPhoto.image = self.originalImage
       // self.originalImage = self.fixOrientation(self.originalImage!)
        
        viewCropper.layer.borderColor = UIColor.white.cgColor
        viewCropper.layer.borderWidth = 2.0
        viewCropper.layer.masksToBounds = true
        
        //......Calculate dynamic frame of viewCropper.....
        let  cWidth = (CScreenWidth * 359) / 375
        let cHeight = (cWidth * 202) / 359
        let cX = (CScreenWidth - cWidth) / 2
        let cY = ((CScreenHeight - cHeight) / 2) - 48
        
        
        //......Scale to fit the screen.....
        let oriWidth = cWidth
        let oriHeight = (self.originalImage?.size.height)! * (cWidth / (self.originalImage?.size.width)!)
        let oriX = cX + (cWidth - oriWidth) / 2
        let oriY = cY + (cHeight - oriHeight) / 2
        
        self.minFrame = CGRect(x: oriX, y: oriY, width: oriWidth, height: oriHeight)
        self.maxFrame = CGRect(x: 0, y: 0, width: LimitRatio * Double(self.minFrame.size.width), height: LimitRatio * Double(self.minFrame.size.height))
        self.currentFrame = self.minFrame
        imgVPhoto.frame = self.minFrame

        //.....AddPinchGesture.....
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchView))
        self.view.addGestureRecognizer(pinchGestureRecognizer)

        //.....AddPanGesture.....
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panView))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        //.....ClearCroppingView Area.....
        let maskLayer = CAShapeLayer()
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: cX, height: CGFloat(CScreenHeight)), transform: .identity)
        path.addRect(CGRect(x: cX + cWidth, y: 0, width: CGFloat((CScreenWidth - cX - cWidth)), height: CGFloat(CScreenHeight)), transform: .identity)
        path.addRect(CGRect(x: 0, y: 0, width: CGFloat(CScreenWidth), height: cY), transform: .identity)
        path.addRect(CGRect(x: 0, y: cY + cHeight, width: CGFloat(CScreenWidth), height: CGFloat((CScreenHeight - cY + cHeight))), transform: .identity)
        maskLayer.path = path as CGPath
        viewOverlay.layer.mask = maskLayer
        

    }
    
    
    func handleScaleOverflow( newFrame: CGRect) -> CGRect {
        
        //.....Bounce To Original Frame.....
        var newFrame = newFrame
        let oriCenter = CGPoint(x: newFrame.origin.x + newFrame.size.width / 2, y: newFrame.origin.y + newFrame.size.height / 2)
        if newFrame.size.width < minFrame.size.width {
            newFrame = minFrame
        }
        if newFrame.size.width > maxFrame.size.width {
            newFrame = maxFrame
        }
        newFrame.origin.x = oriCenter.x - newFrame.size.width / 2
        newFrame.origin.y = oriCenter.y - newFrame.size.height / 2
        return newFrame
    }

    func handleBorderOverflow( newFrame: CGRect) -> CGRect
    {
        //.....Horizontally.....
        var newFrame = newFrame
        if newFrame.origin.x > viewCropper.frame.origin.x {
            newFrame.origin.x = viewCropper.frame.origin.x
        }
        if newFrame.maxX < viewCropper.frame.origin.x + viewCropper.frame.size.width {
            newFrame.origin.x = viewCropper.frame.origin.x + viewCropper.frame.size.width - newFrame.size.width
        }
        //.....Vertically.....
        if newFrame.origin.y > viewCropper.frame.origin.y {
            newFrame.origin.y = viewCropper.frame.origin.y
        }
        if newFrame.maxY < viewCropper.frame.origin.y + viewCropper.frame.size.height {
            newFrame.origin.y = viewCropper.frame.origin.y + viewCropper.frame.size.height - newFrame.size.height
        }
        //.....Adapt Horizontally Rectangle.....
        if imgVPhoto.frame.size.width > imgVPhoto.frame.size.height && newFrame.size.height <= viewCropper.frame.size.height {
            newFrame.origin.y = viewCropper.frame.origin.y + (viewCropper.frame.size.height - newFrame.size.height) / 2
        }
        return newFrame
    }
    
    func cropImage() -> UIImage
    {
        let squareFrame: CGRect = viewCropper.frame
        let scaleRatio: CGFloat = (currentFrame?.size.width)! / originalImage!.size.width
        let x: CGFloat = (squareFrame.origin.x - (currentFrame?.origin.x)!) / scaleRatio
        let y: CGFloat = (squareFrame.origin.y - (currentFrame?.origin.y)!) / scaleRatio
        let w: CGFloat = squareFrame.size.width / scaleRatio
        let h: CGFloat = squareFrame.size.height / scaleRatio
        let myImageRect = CGRect(x: x, y: y, width: w, height: h)
        let imageRef = originalImage?.cgImage
        let subImageRef = imageRef?.cropping(to: myImageRect)
        var size = CGSize()
        size.width = myImageRect.size.width
        size.height = myImageRect.size.height
        UIGraphicsBeginImageContext(size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.draw(subImageRef!, in: myImageRect)
        let smallImage = UIImage(cgImage: subImageRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
    // MARK: -
    // MARK: - UIGestureRecognizer
    
    @objc func pinchView(_ pinchGestureRecognizer: UIPinchGestureRecognizer)
    {
        let view: UIView? = imgVPhoto
        if pinchGestureRecognizer.state == .began || pinchGestureRecognizer.state == .changed {
            view?.transform = (view?.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale))!
            pinchGestureRecognizer.scale = 1
        }
        else if pinchGestureRecognizer.state == .ended {
            var newFrame: CGRect = imgVPhoto.frame
            newFrame = handleScaleOverflow(newFrame: newFrame)
            newFrame = handleBorderOverflow(newFrame: newFrame)
            UIView.animate(withDuration: BOUNDCE_DURATION, animations: {() -> Void in
                self.imgVPhoto.frame = newFrame
                self.currentFrame = newFrame
            })
        }
        
    }

    @objc func panView(_ panGestureRecognizer: UIPanGestureRecognizer)
    {
        let view: UIView? = imgVPhoto
        if panGestureRecognizer.state == .began || panGestureRecognizer.state == .changed {
            //.....Calculate Accelerator.....
            let absCenterX: CGFloat = viewCropper.frame.origin.x + viewCropper.frame.size.width / 2
            let absCenterY: CGFloat = viewCropper.frame.origin.y + viewCropper.frame.size.height / 2
            let scaleRatio: CGFloat = imgVPhoto.frame.size.width / viewCropper.frame.size.width
            let acceleratorX: CGFloat = 1 - abs(absCenterX - (view?.center.x)!) / (scaleRatio * absCenterX)
            let acceleratorY: CGFloat = 1 - abs(absCenterY - (view?.center.y)!) / (scaleRatio * absCenterY)
            let translation: CGPoint = panGestureRecognizer.translation(in: view?.superview)
            view?.center = CGPoint(x:(view?.center.x)! + translation.x * acceleratorX , y:(view?.center.y)! + translation.y * acceleratorY )
            panGestureRecognizer.setTranslation(CGPoint.zero, in: view?.superview)
        }
        else if panGestureRecognizer.state == .ended {
                //.....Bounce To Original Frame.....
                var newFrame: CGRect = imgVPhoto.frame
            newFrame = handleBorderOverflow(newFrame: newFrame)
                UIView.animate(withDuration: BOUNDCE_DURATION, animations: {() -> Void in
                    self.imgVPhoto.frame = newFrame
                    self.currentFrame = newFrame
                })
        }


    }
    
    // MARK: -
    // MARK: -  Action Events

    @IBAction func btnDoneClicked(_ sender: UIButton)
    {
        if self.block != nil
        {
            self.block!(self.cropImage(), nil)
        }
        self.dismiss(animated: true) {}
    }
    
    @IBAction func btnCancleClicked(_ sender: UIButton)
    {
        self.dismiss(animated: true) {}
    }
    
    // MARK: -
    // MARK: -  Fix Orientation
    
    func fixOrientation(_ srcImg: UIImage) -> UIImage
    {
        if srcImg.imageOrientation == .up {
            return srcImg
        }
        var transform: CGAffineTransform = .identity
        switch srcImg.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: srcImg.size.width, y: srcImg.size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: srcImg.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: srcImg.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
        case .up, .upMirrored:
            break
        }
        switch srcImg.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: srcImg.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: srcImg.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
                
        let ctx = CGContext(data: nil, width: Int(srcImg.size.width), height: Int(srcImg.size.height), bitsPerComponent: (srcImg.cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (srcImg.cgImage?.colorSpace)!, bitmapInfo: (srcImg.cgImage?.bitmapInfo)!.rawValue)
        
        ctx?.concatenate(transform)
        
        
        switch srcImg.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(srcImg.cgImage!, in: CGRect(x: 0, y: 0, width: srcImg.size.height, height: srcImg.size.width))

        default:
            ctx?.draw(srcImg.cgImage!, in: CGRect(x: 0, y: 0, width: srcImg.size.width, height: srcImg.size.height))
        }
        let cgimg: CGImage = ctx!.makeImage()!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }

    
}
