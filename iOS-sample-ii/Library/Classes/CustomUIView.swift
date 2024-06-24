//
//  CustomUIView.swift
//  Gobe
//
//  Created by SOTSYS067 on 09/07/19.
//  Copyright © 2019 SOTSYS203. All rights reserved.
//

import UIKit

class RadiusAndBorderView : UIView {
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 25.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        // self.layer.cornerRadius = cornerRadius
        // self.layer.shadowColor = shadowColor.cgColor
        // self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        // self.layer.shadowRadius = shadowBlur
        // self.layer.shadowOpacity = 1
        
    }
}
class CornerRadius : UIView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height * 0.5
        self.clipsToBounds = true
    }
}

class CornerRadiusButton : UIButton {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height * 0.5
        self.clipsToBounds = true
    }
}

class GradientView: UIView {
     
     private var gradientLayer: CAGradientLayer?
     var isGradientShown: Bool = true {
         didSet {
             self.setNeedsDisplay()
         }
     }
  
    var topColor: UIColor = UIColor(red: 37 / 255.0, green: 170 / 255.0, blue: 226 / 255.0, alpha: 1.0) {
         didSet {
             setNeedsLayout()
         }
     }
    var bottomColor:UIColor = UIColor(red: 40 / 255.0, green: 57 / 255.0, blue: 145 / 255.0, alpha: 1.0) {
         didSet {
             setNeedsLayout()
         }
     }
    
      var shadowX: CGFloat = 0 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var shadowY: CGFloat = -3 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var shadowBlur: CGFloat = 3 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var startPointX: CGFloat = 0 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var startPointY: CGFloat = 0.5 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var endPointX: CGFloat = 1 {
         didSet {
             setNeedsLayout()
         }
     }
     
      var endPointY: CGFloat = 0.5 {
         didSet {
             setNeedsLayout()
         }
     }
     
     override class var layerClass: AnyClass {
         return CAGradientLayer.self
     }
     
     override func draw(_ rect: CGRect) {
         super.draw(rect)
         if isGradientShown {
             self.updateProperty(rect: rect)
         }else {
             self.gradientLayer?.removeFromSuperlayer()
             self.layer.cornerRadius = self.frame.height * 0.5
         }
     }
     
     func updateProperty(rect:CGRect) {
        self.gradientLayer?.removeFromSuperlayer()
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer?.frame = self.bounds
        self.gradientLayer?.colors = [topColor.cgColor, bottomColor.cgColor]
        self.gradientLayer?.startPoint = CGPoint(x: startPointX, y: startPointY)
        self.gradientLayer?.endPoint = CGPoint(x: endPointX, y: endPointY)
        if let layer = self.gradientLayer {
            self.layer.insertSublayer(layer, at: 0)
        }
         
        self.layer.cornerRadius = self.frame.height * 0.5
        self.clipsToBounds = true
//        self.maskToBounds = true
     }
     override func layoutSubviews() {
         
        // self.layer.cornerRadius = cornerRadius
        // self.layer.shadowColor = shadowColor.cgColor
        // self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        // self.layer.shadowRadius = shadowBlur
        // self.layer.shadowOpacity = 1
         
     }
     
     func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
         let fromColors = self.gradientLayer?.colors
         let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
         self.gradientLayer?.colors = toColors
         let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
         animation.fromValue = fromColors
         animation.toValue = toColors
         animation.duration = duration
         animation.isRemovedOnCompletion = true
         animation.fillMode = .forwards
         animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
         self.gradientLayer?.add(animation, forKey:"animateGradient")
     }
 }

class defaultNavigationGobe : UINavigationController {

    override func viewDidLoad() {
        /// Hide default 1px border line of Navigation Bar
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
}
class roundImageView: UIImageView {

    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
    }

    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
