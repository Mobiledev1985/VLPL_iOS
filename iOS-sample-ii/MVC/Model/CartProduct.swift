//
//  CartProduct.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation

struct CartProduct: Codable {
    var product_list: [CartsProductList]?
    var sub_total_amount, total_gst, total_amount: String?
    var total_free_qty: Int?
    var total_cart_qty: Int?
    var total_incentive_points: Int?
    var total_product_qty: Int?
    var address: GetAddressList?
    var top_deals_list: [ProductData]?
    var stockiest_detail : Stockiest_detail?
    var mr_detail : Mr_detail?
}

// MARK: - ProductList
struct CartsProductList: Codable {
    var id, product_id, quantity, sequence: Int?
    var product: ProductData?
}
