//
//  UIImageView+Extension.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit
import SDWebImage

extension UIImage {
   
    func resizeImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIImageView {
    func setImage(imageUrl : String, placeHolder: String = "Default") {
        self.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: placeHolder))
    }
}
