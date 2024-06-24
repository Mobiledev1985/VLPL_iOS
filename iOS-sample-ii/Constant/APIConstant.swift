//
//  APIConstant.swift
//  LR_BaseCode
//
//  Created by Admin on 28/3/2023.
//
import Foundation
//USERDEFAULT KEYS
let kDeviceToken = "DEVICE_TOKEN"
let kDeviceUUIDString = "DEVICE_UUID_STRING"
let kAuthKey = "vAuthKey"
let kUserIDKey = "vUserID"
let kBadgeCount = "vBadgeCount"
let kUserlat = "vUserlat"
let kUserlng = "vUserlng"
let kUserPWD = "vUserPWD"
let kUser = "kUser"


struct APIConstant {
    struct ResponseCode {
        static let success = 200
        static let failed = 400
        static let unAuthorized = 203
        static let noData = 204
    }
  
    static let baseUrl = "http://dev2.spaceo.in/project/online_charter/api/v1"
}
