//
//  LoginResponseModel.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct LoginResponseModel : Decodable {
    
    let errorMessage: String?
    let data: LoginResponseData?
}

struct LoginResponseData : Decodable, Encodable {
    let userName: String
    let userID: Int
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case userID = "userId"
        case email
    }
}
