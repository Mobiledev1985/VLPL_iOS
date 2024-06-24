//
//  BaseModel.swift
//  iOS-sample-i
//
//  Created by Parth iOS  on 11/07/23.
//

import UIKit

class BaseModel:NSObject,Codable{
    var responseCode: Int?
    var responseMessage: String = ""

    init(responseCode: Int?, responseMessage:String) {
        self.responseCode = responseCode
        self.responseMessage = responseMessage
    }
}
