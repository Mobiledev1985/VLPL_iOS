//
//  UIView+Extension.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit
import UniformTypeIdentifiers
extension UIView {

        
    class func initFromNib<T: UIView>() -> T {
        return Bundle.init(for: self.classForCoder()).loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as? T ?? T()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCornersWithShadow(corners: UIRectCorner, radius: CGFloat, bgColor: UIColor) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
//        layer.mask = mask
        
        mask.fillColor = bgColor.cgColor//UIColor.white.cgColor

        let shadowLayer = CAShapeLayer()
        shadowLayer.shadowColor = Colors.gray.returnColor().cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 6.0)
        shadowLayer.shadowRadius = 3.0//10.0
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowPath = mask.path

        self.layer.insertSublayer(shadowLayer, at: 0)
        self.layer.insertSublayer(mask, at: 1)
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    
    //Kishor
    func roundCorners(radius: CGFloat, arrCorners: CACornerMask) {

        self.clipsToBounds = false
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = arrCorners
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy"
        return dateFormatter.string(from: self)
    }
}

extension Data {
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "unknown"
        }
        return ext
    }
}

extension URL {
    public func mimeType() -> String {
        if #available(iOS 14.0, *) {
            if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
                return mimeType
            }
            else {
                return "application/pdf"
            }
        } else {
            return "application/pdf"
        }
    }
}
