//
//  CustomNoRecordFoundView.swift
//  MedSpaMaps
//
//  Created by SOTSYS115 on 7/13/18.
//  Copyright © 2018 SOTSYS203. All rights reserved.
//

import UIKit

class CustomNoRecordFoundView: UIView {

    @IBOutlet weak var lblMessage: UILabel!

    func setMessage(_ message: String = "No record found") {
        lblMessage.text = message
    }
}
