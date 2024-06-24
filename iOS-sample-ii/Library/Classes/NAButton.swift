//
//  NAButton.swift
//  AppWayUser
//
//  Created by SOTSYS115 on 8/3/18.
//  Copyright © 2018 SOTSYS203. All rights reserved.
//

import UIKit

@IBDesignable class NAButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        self.titleLabel?.font = UIFont.mediumFont(ofSize: 17.0)
        self.layer.cornerRadius = 5.0
        self.layer.backgroundColor = UIColor.blue.cgColor
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
        refreshCorners(value: cornerRadius)

        // Common logic goes here
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    //IBInspectable
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }


}
