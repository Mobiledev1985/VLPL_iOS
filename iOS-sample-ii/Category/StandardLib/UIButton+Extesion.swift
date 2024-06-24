//
//  UIButton+Extesion.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit
extension UIButton {
    
    func setLeftArrow(title: String) {
        self.setImage(UIImage(named: "plus"), for: .normal)
        self.tintColor = UIColor.white
        
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top:0, left:-10, bottom:0, right:0)
    }
}
