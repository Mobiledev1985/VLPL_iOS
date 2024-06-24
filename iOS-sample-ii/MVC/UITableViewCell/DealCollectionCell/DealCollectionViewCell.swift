//
//  DealCollectionViewCell.swift
//  vlpl_ios
//
//  Created by apple on 06/05/22.
//

import UIKit

class DealCollectionViewCell: UICollectionViewCell {

    
    //MARK: Outlets
    @IBOutlet weak var vwDealCell: UIView!
    @IBOutlet weak var imgVwMedicines: UIImageView!
    @IBOutlet weak var lblMedicineName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPtrPts: UILabel!
    
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblFreeQty: UILabel!
    @IBOutlet weak var lblTotalQty: UILabel!
    @IBOutlet weak var lblFreeQtyValue: UILabel!
    @IBOutlet weak var lblTotalQtyValue: UILabel!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var lblRedOfferDiscount: UILabel!

    //MARK: Declarations
    var index = 0
    var section = 0
    var onPlusBtnClick : ((Int, Int)->Void)? //OBSERVER Method
    var onMinusBtnClick : ((Int, Int)->Void)?
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        vwDealCell.layer.cornerRadius = 6
        vwDealCell.clipsToBounds = true
//        vwDealCell.addShadow(offset: CGSize(width: 0, height: -3.0), color: Colors.gray.returnColor(), radius: 2.0, opacity: 0.25)
        imgVwMedicines.layer.cornerRadius = 10.0
        self.lblRedOfferDiscount.layer.cornerRadius = self.lblRedOfferDiscount.layer.frame.height / 2
    }
    
    //MARK: IBActions
    @IBAction func onClickPlusButton(_ sender: UIButton) {
        if onPlusBtnClick != nil{
            onPlusBtnClick!(index, section)
        }
    }
    
    @IBAction func onClickMinusButton(_ sender: UIButton) {
        if onMinusBtnClick != nil{
            onMinusBtnClick!(index, section)
        }
    }
    
    
}
