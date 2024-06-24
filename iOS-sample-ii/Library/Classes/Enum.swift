//
//  Enum.swift
//  AircraftApp
//
//  Created by SOTSYS040 on 12/02/20.
//  Copyright © 2020 SOTSYS203. All rights reserved.
//


import UIKit
import Moya
import SwiftyJSON

enum enStoryboardName : String {
    
    case Main = "Main"
}

enum appFonts : String {
    
    case SegoeUISemibold = "SegoeUI-Semibold",
    SegoeUISemilight = "SegoeUI-Semilight",
    SegoeUIBoldItalic = "SegoeUI-BoldItalic",
    SegoeUIBlack = "SegoeUIBlack",
    SegoeUISemiboldItalic = "SegoeUI-SemiboldItalic",
    SegoeUIItalic = "SegoeUI-Italic",
    SegoeUIBlackItalic = "SegoeUIBlack-Italic",
    SegoeUILightItalic = "SegoeUI-LightItalic",
    SegoeUIBold = "SegoeUI-Bold",
    SegoeUI = "SegoeUI",
    SegoeUILight = "SegoeUI-Light",
    SegoeUISemilightItalic = "SegoeUI-SemilightItalic"
    
}

enum Colors {
    
    case theme, themeLight, gray, lightGray, red, orange, green, blue, lightBlue, paymetnFailed, placeholder,disabledTextFiled
    
    func returnColor() -> UIColor {
        switch self {
        case .theme: //rgba(0, 87, 120, 1)
            return UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        case .themeLight: //93C572
            return UIColor(red: 231/255.0, green: 248/255.0, blue: 255/255.0, alpha: 1.0)
        case .gray: //5A5A5A
            return UIColor(red: 118/255.0, green: 118/255.0, blue: 118/255.0, alpha: 1.0)
        case .lightGray: //ACACAC
            return UIColor(red: 178/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1.0)
        case .red: //FF0800
            return UIColor(red: 255.0/255.0, green: 8.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .orange: //FF0800
            return UIColor(red: 245/255.0, green: 130/255.0, blue: 32/255.0, alpha: 1.0)
        case .green: //#00A455
            return UIColor(red: 0/255.0, green: 164/255.0, blue: 85/255.0, alpha: 1.0)
        case .blue:  //#3395FF
            return UIColor(red: 51/255.0, green: 149/255.0, blue: 255/255.0, alpha: 1.0)
        case .lightBlue: //#F2F6F8
            return UIColor(red: 242/255.0, green: 246/255.0, blue: 248/255.0, alpha: 1)
        case .paymetnFailed: //#FE5E5E
            return UIColor(red: 254/255.0, green: 94/255.0, blue: 94/255.0, alpha: 1)
        case .placeholder: //#C9C9CB
            return UIColor(red: 201/255.0, green: 201/255.0, blue: 203/255.0, alpha: 1)
        case .disabledTextFiled:
            return UIColor(red: 178/255.0, green: 187/255.0, blue: 187/255.0, alpha: 0.1)
        }
    }
}


enum AlertType:Int {
    case Error = 1
    case Success
    case Warning
}

enum Fonts {
    case Regular, Bold, Thin, BoldItalic, Light, LightItalic, ExtraBold, ExtraLight, Semibold, Black, Medium
    
    func returnFont(size: CGFloat) -> UIFont {
        switch self {
        case .Regular:
            return UIFont(name: "Inter-Regular", size: size)!
        case .Bold:
            return UIFont(name: "Inter-Bold", size: size)!
        case .Thin:
            return UIFont(name: "Inter-Thin", size: size)!
        case .BoldItalic:
            return UIFont(name: "Poppins-BoldItalic", size: size)!
        case .Light:
            return UIFont(name: "Inter-Light", size: size)!
        case .LightItalic:
            return UIFont(name: "Poppins-LightItalic", size: size)!
        case .ExtraBold:
            return UIFont(name: "Inter-ExtraBold", size: size)!
        case .ExtraLight:
            return UIFont(name: "Inter-ExtraLight", size: size)!
        case .Semibold:
            return UIFont(name: "Inter-SemiBold", size: size)!
        case .Black:
            return UIFont(name: "Inter-Black", size: size)!
        case .Medium:
            return UIFont(name: "Inter-Medium", size: size)!
        }
    }
}
