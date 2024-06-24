//
//  PaymentDetailsView.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
import UIKit
class PaymentDetailsView: UIView {

    @IBOutlet weak var vwBackGround: UIView!
    @IBOutlet weak var lblMRPTotal: UILabel!
    @IBOutlet weak var lblGST: UILabel!
    @IBOutlet weak var lblProductPoints: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMRPTitle: UILabel!
    
    var price : OrderDetail?
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwBackGround.layer.masksToBounds = true
        vwBackGround.clipsToBounds = false
        
    }
    
    static func instantiate(title: String) -> PaymentDetailsView {
// To Give Dynamic Header Label to Bill Detail and Payment Detail XIB'S and show it wherever both XIB'S are Loaded.
        let view: PaymentDetailsView = initFromNib()
        view.lblTitle.text = title
        return view
    }
    
}
