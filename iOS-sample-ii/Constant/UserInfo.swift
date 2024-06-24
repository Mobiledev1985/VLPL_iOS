//
//  UserInfo.swift
//  LR_BaseCode
//
//  Created by Admin on 28/3/2023.
//
import Foundation
import UIKit

struct DefaultsKey<ValueType> {
    private let key: String
    private let defaultValue: ValueType
    
    public init(_ key: String, defaultValue: ValueType) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var value: ValueType {
        get {
            let value = UserDefaults.standard[key]
            return value as? ValueType ?? defaultValue
        }
        set {
            UserDefaults.standard[key] = newValue as AnyObject
            UserDefaults.standard.synchronize()
        }
    }
}


class UserInfo {
    static let shared = UserInfo()
    private var _userId = DefaultsKey<Int>(kUserIDKey, defaultValue: 0)
    var userId: Int {
        get { return _userId.value }
        set { _userId.value = newValue }
    }
        
    private var _auth_token = DefaultsKey<String>(kAuthKey, defaultValue: "")
    var auth_token: String {
        get { return "Bearer \(_auth_token.value)" }
        set { _auth_token.value = newValue }
    }
    
    var loggedInUser:BaseModel?{
        get{
            if let decoded  =  UserDefaults.standard.object(BaseModel.self, with: kUser){
                return decoded
            }
            return nil
        }
        set{
            UserDefaults.standard.set(object: newValue!, forKey: kUser)
            UserDefaults.standard.synchronize()
        }
    }
   
    
    private var _device_token = DefaultsKey<String>(kDeviceToken, defaultValue: "123")
    var device_token: String {
        get { return _device_token.value }
        set { _device_token.value = newValue }
    }
    
    private var _userLat = DefaultsKey<Double>(kUserlat, defaultValue: 0)
    var userLat: Double {
        get { return _userLat.value }
        set { _userLat.value = newValue }
    }
    
    
    private var _userLng = DefaultsKey<Double>(kUserlng, defaultValue: 0)
    var userLng: Double {
        get { return _userLng.value }
        set { _userLng.value = newValue }
    }
    

}


extension UIFont {
    static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func normalFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SegoeUI-SemiBold", size: size)
    }
    static func mediumFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SegoeUI-Bold", size: size)
    }
    
}
