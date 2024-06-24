//
//  ProductData.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct ProductData: Codable {
    let id: Int?
    let title:String?
    let discount: String?
    let slug: String?
    var free_product_qty: Int?
    let product_qty: Int?
    let discount_type: Int?
    let product_strips: String?
    let composition: String?
    let photo: [String]?
    let status: String?
    let category_name: String?
    let final_price: String?
    let price: String?
    let product_gst:Int?
    let product_type:String?
    let offer_price: String?
    let mrp_price: String?
    let offer_discount: String?
    var ratio: Int?
    let discount_price: String?
    let description, date: String?
    var cart_qty: Int?
    var sequence: Int?
    var cart_free_qty: Int?
    var total_cart_qty: Int?
    var quantity: Int?
    var is_review: Bool?
    let ratings: Float?
    let reviews: Reviews?
}

struct Reviews: Codable {
    let avg_rating: Float?
    let total_review: Int?
    let reviews_data: [ReviewsData]
}

struct ReviewsData: Codable {
    let rate: Int
    let review, user_name: String
}
