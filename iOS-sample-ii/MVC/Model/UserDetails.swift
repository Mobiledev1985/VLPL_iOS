//
//  UserDetails.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
struct UserDetails: Codable {
    let roleSlug, roleName, fullName,firstName,lastName, firmName: String?
    let email: String?
    let stateName: String?
    let cityName: String?
    let pincode: Int?
    let contactNo1, contactNo2, gstNo, drugLicenceNo,drugLicenceNo2: String?
    let gstDocument, drugDocument,drugDocument2,idProofDocument,fssaiDocument: String?
    let isNewPush: Int?
    
    enum CodingKeys: String, CodingKey {
        case roleSlug = "role_slug"
        case roleName = "role_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case firmName = "firm_name"
        
        case email
        case stateName = "state_name"
        case cityName = "city_name"
        case pincode
        case contactNo1 = "contact_no_1"
        case contactNo2 = "contact_no_2"
        case gstNo = "gst_no"
        case drugLicenceNo = "drug_licence_no"
        case drugLicenceNo2 = "drug_license_no_2"
        case gstDocument = "gst_document"
        case drugDocument = "drug_document"
        case drugDocument2 = "drug_document_2"
        case fssaiDocument = "fssai_document"
        case idProofDocument = "id_proof_documentid_proof_documentid_proof_document"
        case isNewPush = "is_new_push"
    }
}
