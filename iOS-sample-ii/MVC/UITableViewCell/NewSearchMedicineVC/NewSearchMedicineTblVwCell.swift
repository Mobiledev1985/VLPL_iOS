//
//  NewSearchMedicineTblVwCell.swift
//  vlpl_ios
//
//  Created by apple on 14/10/22.
//

import UIKit

class NewSearchMedicineTblVwCell: UITableViewCell {

// MARK: Outlets
    @IBOutlet weak var vwMainBackground: UIView!
    @IBOutlet weak var lblMedicineName: UILabel!
    @IBOutlet weak var lblMedicineCategory: UILabel!
    @IBOutlet weak var imgVwMedicine: UIImageView!
    @IBOutlet weak var lblMrpPrice: UILabel!
    @IBOutlet weak var lblScriptQty: UILabel!
    @IBOutlet weak var lblPtrPtsPrice: UILabel!
    @IBOutlet weak var lblMedicinePrice: UILabel!
    @IBOutlet weak var lblRedOfferDiscount: UILabel!
    @IBOutlet weak var lblBillQty: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblFreeQuantityValue: UILabel!
    @IBOutlet weak var lblTotalQuantityValue: UILabel!
    @IBOutlet weak var lblFreeQty: UILabel!
    @IBOutlet weak var lblTotalQty: UILabel!
    @IBOutlet weak var btnDeleteCartItem: UIButton!
    @IBOutlet weak var lblGSTValue: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblPtrPtsPriceValue: UILabel!
    
    //MARK: Declarations
    var index = 0
    var section = 0
    var onPlusBtnClick : ((Int, Int)->Void)? //OBSERVER Method
    var onMinusBtnClick : ((Int, Int)->Void)?
    var onDeleteBtnClick : ((Int)->Void)?
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwMainBackground.layer.cornerRadius = 8
        imgVwMedicine.layer.borderColor = Colors.lightGray.returnColor().cgColor
        imgVwMedicine.layer.borderWidth = 0.3
        imgVwMedicine.clipsToBounds = true
        imgVwMedicine.layer.cornerRadius = 5
        
        self.lblRedOfferDiscount.layer.cornerRadius = self.lblRedOfferDiscount.layer.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    @IBAction func onClickDeleteButton(_ sender: UIButton) {
        if onDeleteBtnClick != nil{
            onDeleteBtnClick!(index)
        }
    }
}
