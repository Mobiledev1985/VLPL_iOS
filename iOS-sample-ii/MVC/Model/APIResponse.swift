//
//  APIResponse.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct ApiResponse: Codable {
    var status: Int?
    var result: Response?
    var message: String?
}

struct Response: Codable {
    
    var cart_data: CartProduct?
    var apply_points : ApplyPoints?

}


struct ApplyPoints : Codable{
    let amount : Int?
}
