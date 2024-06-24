//
//  OrderDetail.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct OrderDetail: Codable {
    let id: Int?
    var order_number, status, delivered: String?
    let sub_total_amount: String?
    let total_amount: String?
    var date: String?
    let total_item: Int?
    let points: String?
    let gst: String?
    let product_name: String?
    let product_info: [ProductData]?
    var invoice_already_uploaded: Int?
}
