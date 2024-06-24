//
//  UILabel+Extension.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit

extension UILabel {
    func getEmptyValidationString(_ string: String) {
        
        var tmpString: String = string
        var arrString = tmpString.split(separator: " ")
        if arrString.count > 0 {
            if arrString[0].uppercased() == "Enter".uppercased() || arrString[0].uppercased() == "Select".uppercased() {
                arrString.removeFirst()
                tmpString = arrString.joined(separator: " ")
            }
        }
        
        self.setLeftArrow(title: "Please enter \(tmpString)")
    }

    func getValidationString(_ string: String) {
        
        var tmpString: String = string
        var arrString = tmpString.split(separator: " ")
        if arrString.count > 0 {
            if arrString[0].uppercased() == "Enter".uppercased() || arrString[0].uppercased() == "Select".uppercased() {
                arrString.removeFirst()
                tmpString = arrString.joined(separator: " ")
            }
        }
        
        self.setLeftArrow(title: "Please enter valid \(tmpString)")
    }
    
    func setLeftArrow(title: String) {
//        self.font = Fonts.Regular.returnFont(size: 12.0)
        self.textColor = Colors.red.returnColor()
//        let loginString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
//        let attachment = NSTextAttachment()
//        attachment.image = UIImage(imageLiteralResourceName: "Error")
//        var attachmentString = NSAttributedString()
//        attachmentString = NSAttributedString(attachment: attachment)
//        loginString.append(attachmentString)
//        loginString.append(NSAttributedString(string: " \(title)"))
//        self.attributedText = loginString
        self.text = title
    }
    
    func setAttributedRequiredText() {
        let attributedString = NSMutableAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font: Fonts.Regular.returnFont(size: 13.0)])
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: self.text!.trimmedString.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.red.returnColor(), range: NSRange(location: self.text!.trimmedString.count - 1, length: 1))

        self.attributedText = attributedString
    }
    
    func setUnderLine(text: String) {
        
        let main_string = self.text
        let range = (main_string! as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string:main_string!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.attributedText = attributedString
        
    }
    
}
