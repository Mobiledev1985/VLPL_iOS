//
//  LRUIViewExtesion.swift
//  LR_BaseCode
//
//  Created by Admin on 28/3/2023.
//

import Foundation
import UIKit

extension UIView {
    
    struct ViewTag {
        static let tBackgroundImageView = 10001;
    }
    
    
    func addBackgroundImageLoginBG(){
        self.addBackgroundImage("loginbg");
    }
    
    
    func addBackgroundImage(_ named : String){
        let imageView = UIImageView(image: UIImage(named: named));
        imageView.contentMode = UIView.ContentMode.scaleAspectFill;
        imageView.tag = UIView.ViewTag.tBackgroundImageView;
        
        delay(0.1) {
            imageView.frame = self.bounds;
        }
        self.insertSubview(imageView, at: 0);
    }
    
    func rotate(angle degree : CGFloat){
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI)*degree/180.0);
        }) ;
    }
   
    func setColorInView(color: UIColor, width: CGFloat, radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layoutIfNeeded()

    }
    
    func getImage()->UIImage {
        UIGraphicsBeginImageContextWithOptions(self.layer.frame.size, false, 1.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.cgImage!)
    }
    
    func rotateAnimation(duration: CFTimeInterval = 2.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = FLT_MAX;
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    public func addTopRoundCorner(width: CGFloat,height:  CGFloat)
    {
        let path = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: self.w, height: self.h),
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 5.0, height:  5.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }


}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
