//
//  Mr_detail.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct Mr_detail : Codable {
    let id : Int?
    let firm_name : String?
    let full_name : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let total_points : Int?
    let state : String?
    let city : String?
    let pincode : Int?
    let contact_no_1 : String?
    let contact_no_2 : String?
    let gst_no : String?
    let gst_document : String?
    let drug_licence_no : String?
    let drug_license_no_2 : String?
    let drug_document : String?
    let drug_document_2 : String?
    let fssai_document : String?
    let id_proof_document : String?
    let designation : String?
    let fcm_token : String?
    let is_new_push : Int?
    let is_verified : Int?
    let status : String?
    let resion : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let is_delete : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firm_name = "firm_name"
        case full_name = "full_name"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case total_points = "total_points"
        case state = "state"
        case city = "city"
        case pincode = "pincode"
        case contact_no_1 = "contact_no_1"
        case contact_no_2 = "contact_no_2"
        case gst_no = "gst_no"
        case gst_document = "gst_document"
        case drug_licence_no = "drug_licence_no"
        case drug_license_no_2 = "drug_license_no_2"
        case drug_document = "drug_document"
        case drug_document_2 = "drug_document_2"
        case fssai_document = "fssai_document"
        case id_proof_document = "id_proof_document"
        case designation = "designation"
        case fcm_token = "fcm_token"
        case is_new_push = "is_new_push"
        case is_verified = "is_verified"
        case status = "status"
        case resion = "resion"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case deleted_at = "deleted_at"
        case is_delete = "is_delete"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firm_name = try values.decodeIfPresent(String.self, forKey: .firm_name)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        total_points = try values.decodeIfPresent(Int.self, forKey: .total_points)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        pincode = try values.decodeIfPresent(Int.self, forKey: .pincode)
        contact_no_1 = try values.decodeIfPresent(String.self, forKey: .contact_no_1)
        contact_no_2 = try values.decodeIfPresent(String.self, forKey: .contact_no_2)
        gst_no = try values.decodeIfPresent(String.self, forKey: .gst_no)
        gst_document = try values.decodeIfPresent(String.self, forKey: .gst_document)
        drug_licence_no = try values.decodeIfPresent(String.self, forKey: .drug_licence_no)
        drug_license_no_2 = try values.decodeIfPresent(String.self, forKey: .drug_license_no_2)
        drug_document = try values.decodeIfPresent(String.self, forKey: .drug_document)
        drug_document_2 = try values.decodeIfPresent(String.self, forKey: .drug_document_2)
        fssai_document = try values.decodeIfPresent(String.self, forKey: .fssai_document)
        id_proof_document = try values.decodeIfPresent(String.self, forKey: .id_proof_document)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        is_new_push = try values.decodeIfPresent(Int.self, forKey: .is_new_push)
        is_verified = try values.decodeIfPresent(Int.self, forKey: .is_verified)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        resion = try values.decodeIfPresent(String.self, forKey: .resion)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        is_delete = try values.decodeIfPresent(Int.self, forKey: .is_delete)
    }

}
