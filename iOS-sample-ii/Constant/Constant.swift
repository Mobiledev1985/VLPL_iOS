//
//  Constant.swift
//  LR_BaseCode
//
//  Created by Admin on 28/3/2023.
//
import UIKit



let NLoadingViewTag = 55555
let DEVICENAME = UIDevice.current.name
let DEVICETYPE = "2"
let USERTYPE = "1"
let DEVICEID = UIDevice.current.identifierForVendor?.uuidString ?? ""

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
}

let WINDOW_WIDTH = UIScreen.main.bounds.width
let WINDOW_HEIGHT = UIScreen.main.bounds.height

let SecondsTimeOffSet = TimeZone.current.secondsFromGMT()
let localTimeZone = TimeZone.current.identifier

class TokenGenerate:NSObject{
    var nonce:String = ""
    var token:String = ""
    var timestamp:String = ""
    static var sharedToken: TokenGenerate!
}

struct Constants {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
}

/*---------------------------------------------------
 //MARK:- Custom Print Fuction
 ---------------------------------------------------*/
/// Prints any given parameter only while in dubug mode
///
/// - Parameter items: any thing you like to make print
func vPrint(_ items: Any...) {
    #if DEBUG
    for item in items {
        print(item)
    }
    #endif
}

struct UserDefaultType {
    static let isLogin = "isLogin"
    static let isFirstTimeOnly = "isFirstTimeOnly"
    static let accessToken = "accessToken"
    static let fcmToken = "fcmToken"
    static let notification = "notification"
    static let userRoleType = "userRoleType"
}
