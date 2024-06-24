//
//  GetAddressList.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation

struct GetAddressList: Codable {
    var id: Int?
    var building_name, street_name: String?
    var pincode: Int?
    var city: String?
//    var is_primary: Int?
}
