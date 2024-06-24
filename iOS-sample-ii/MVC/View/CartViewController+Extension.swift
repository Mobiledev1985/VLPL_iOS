//
//  CartViewController+Extension.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 13/7/2023.
//

import UIKit

extension CartViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData?.product_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewSearchMedicineTblVwCell", for: indexPath) as! NewSearchMedicineTblVwCell
        cell.btnDeleteCartItem.isHidden = false
        
        cell.index = indexPath.row
        cell.section = indexPath.section
        
        let productDetails = cartData?.product_list?[indexPath.row].product
        
        cell.imgVwMedicine.setImage(imageUrl: "\(productDetails?.photo?[0] ?? "")")
        cell.lblMedicineName.text = productDetails?.title
        cell.lblMedicineCategory.text = productDetails?.composition
        cell.lblGSTValue.text = "+GST (\(productDetails?.product_gst ?? 0)%)"
        cell.lblFreeQuantityValue.text = "\(productDetails?.cart_free_qty ?? 0)"
        cell.lblTotalQuantityValue.text = "\(productDetails?.total_cart_qty ?? 0)"
        cell.lblQuantity.text = "\(productDetails?.cart_qty ?? 0)"
        
        if (productDetails?.cart_qty ?? 0)! == 0 {
            cell.btnMinus.isEnabled = false
            cell.btnMinus.setImage(UIImage(named: "minusGrayIcon"), for: .normal)
        }else {
            cell.btnMinus.isEnabled = true
            cell.btnMinus.setImage(UIImage(named: "minusIcon"), for: .normal)
        }
        
        // DISOUNT TYPE 3 then Labels will be hidden else it will be unhided.
        cell.lblBillQty.isHidden = true
        cell.lblFreeQty.isHidden = true
        cell.lblTotalQty.isHidden = true
        cell.lblFreeQuantityValue.isHidden = true
        cell.lblTotalQuantityValue.isHidden = true
        
//        cell.lblPtrPtsPrice.text = showPtrPts()
        cell.lblPtrPtsPrice.text = "Your price*"
        
        if let value = productDetails?.mrp_price {
            cell.lblMrpPrice.text = "Rs.\(value)"
        }
        if let value = productDetails?.product_type {
            cell.lblProductType.text = "( Per \(value) )"
//            cell.lblScriptQty.text = "(Per \(value))"
        }
        if let value = productDetails?.product_strips {
            cell.lblScriptQty.text = "\(value)"
        }
    
        cell.lblPtrPtsPriceValue.isHidden = true
        
        cell.lblRedOfferDiscount.isHidden = true
        if productDetails?.discount_type == 0 {
            cell.lblRedOfferDiscount.isHidden = true
            cell.lblPtrPtsPriceValue.isHidden = true
            if let value = productDetails?.price {
                cell.lblMedicinePrice.text = "Rs.\(value)"
            }
        }else if (productDetails?.discount_type == 1){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = "  FLAT \(productDetails?.discount ?? "")\u{20B9} OFF  "
            //            cell.lblPtrPtsPriceValue.isHidden = false
            if let value = productDetails?.final_price {
                cell.lblMedicinePrice.text = "Rs.\(value)"
            }
            //            if let value = productDetails?.price {
            //                cell.lblPtrPtsPriceValue.attributedText = "Rs.\(value)".strikeThrough()
            //            }
        }else if (productDetails?.discount_type == 2){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = " \(productDetails?.discount ?? "")% OFF "
            //            cell.lblPtrPtsPriceValue.isHidden = false
            if let value = productDetails?.final_price {
                cell.lblMedicinePrice.text = "Rs.\(value)"
            }
            //            if let value = productDetails?.price {
            //                cell.lblPtrPtsPriceValue.attributedText = "Rs.\(value)".strikeThrough()
            //            }
        }else if (productDetails?.discount_type == 3){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = "  Buy \(productDetails?.product_qty ?? 0) Get \(productDetails?.free_product_qty ?? 0) Free   "
            cell.lblBillQty.isHidden = false
            cell.lblFreeQty.isHidden = showHideLabel(cartQty: productDetails?.cart_free_qty)
            cell.lblTotalQty.isHidden = showHideLabel(cartQty: productDetails?.total_cart_qty)
            cell.lblFreeQuantityValue.isHidden = showHideLabel(cartQty: productDetails?.cart_free_qty)
            cell.lblTotalQuantityValue.isHidden = showHideLabel(cartQty: productDetails?.total_cart_qty)
            //            cell.lblPtrPtsPriceValue.isHidden = true
            if let value = productDetails?.price {
                cell.lblMedicinePrice.text = "Rs.\(value)"
            }
        }
        //        cell.lblRedOfferDiscount.layer.cornerRadius = cell.lblRedOfferDiscount.layer.frame.height / 2
        
        cell.onDeleteBtnClick = { [self] index in
            let deleteProduct = UIAlertController(title: nil, message: "Are you sure you want to delete this product?", preferredStyle: UIAlertController.Style.alert)
            
            
            deleteProduct.addAction(UIAlertAction(title:"Cancel", style: .default, handler: { (action: UIAlertAction) in
                deleteProduct.dismiss(animated: true)
            }))
            
            deleteProduct.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) in
                self.removeFromCart(id: (cartData?.product_list?[index].id)!)
            }))
            
            present(deleteProduct, animated: true, completion: nil)
        }
        
        cell.onPlusBtnClick = { [self] index, section in
            
            if(cartData?.product_list?[index].product?.discount_type == 3){
                self.sequence = (cartData?.product_list?[index].sequence)! + 1
            }
            self.addToCart(productId: cartData?.product_list?[index].product?.id ?? 0 , quantity: cartData?.product_list?[index].product?.ratio ?? 1, sequenc: self.sequence) { [self] response in
                
                self.getCartData()
            }
        }
        
        cell.onMinusBtnClick = { [self] index, section in
            if(cartData?.product_list?[index].product?.cart_qty ?? 0 > 0) {
                let minusValue = Int("-\(cartData?.product_list?[index].product?.ratio ?? 0)") ?? 0
                print("MINUS VAL is:-  \(minusValue)")
                if(cartData?.product_list?[index].product?.discount_type == 3){
                    self.sequence = (cartData?.product_list?[index].sequence)! - 1
                }
                self.addToCart(productId: cartData?.product_list?[index].product?.id ?? 0 , quantity: minusValue, sequenc: self.sequence) { [self] response in
                    
                    self.getCartData()
                    
                }
            }
        }
        
        //        // To Give Rounded Corners to Table View Cell
        //        if indexPath.row == 0 && indexPath.row == arrProdList.count-1 {
        cell.vwMainBackground.roundCorners(radius: 6, arrCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        //        }else if indexPath.row == 0 {
        //            cell.vwMainBackground.roundCorners(radius: 6, arrCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        //        }else if indexPath.row == arrProdList.count-1 {
        //            cell.vwMainBackground.roundCorners(radius: 6, arrCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        //        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((self.cartData?.product_list?.count ?? 0) * 360)
    }
    
}

extension CartViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == txtFieldPoints {
            return Int(newString as String) ?? 0 <= self.cartData?.total_incentive_points ?? 0
        }
        
        return true
        
    }
    
    //MARK: GET CART DATA API
    func getCartData(){
        if !NetworkReachabilityManager()!.isReachable {
            self.isRetryInternet { (isretry) in
                if isretry!{
                    self.getCartData()
                }
            }
            return
        }
        self.showLoading()
        APIManager.sharedManager.getData(url: APIManager.sharedManager.GET_CART_PRODUCTS, parameters: nil) { (response: ApiResponse?, error) in
            self.hideLoading()
            if response?.status == 200{
                DispatchQueue.main.async { [self] in
                    self.cartData = response?.result?.cart_data
                    //                    self.getPoints = response?.result?.cart_data?.total_incentive_points ?? 0
                    
                    self.vwMain.isHidden = false
                    if let mrDetails = self.cartData?.mr_detail {
                        self.mrDetailsView.isHidden = false
                        self.lblMrName.text = mrDetails.full_name
                        self.lblMrEmail.text = mrDetails.email
                        self.lblMrMobileNumber.text = mrDetails.contact_no_1
                    } else {
                        self.mrDetailsView.isHidden = true
                        
                    }
                    
                    if let stokiestDetails = self.cartData?.stockiest_detail {
                        self.stokiestDetailView.isHidden = false
                        self.mrDetailsView.isHidden = false
                        self.lblStokiestName.text = stokiestDetails.full_name
                        self.lblStokiestEmail.text = stokiestDetails.email
                        self.lblStokiestNumber.text = stokiestDetails.contact_no_1
                    } else {
                        self.stokiestDetailView.isHidden = true
                    }
                    paymentDetailsView.lblMRPTotal.text = "Rs.\(self.cartData?.sub_total_amount ?? "0.00")"
                    paymentDetailsView.lblGST.text = "Rs.\(self.cartData?.total_gst ?? "0.00")"
                    
                    paymentDetailsView.lblTotalPrice.text = "Rs.\(self.cartData?.total_amount ?? "0.00")"
                    
                    self.lblTotalAmount.text = "Rs. \(self.cartData?.total_amount ?? "0.00")"
                    
                    self.getAppliedPoints = 0
                    self.lblTotalPoints.text = "\(self.cartData?.total_incentive_points ?? 0) Points"
                    self.paymentDetailsView.lblProductPoints.text = String(format: "-Rs. %.2f", self.getAppliedPoints)
                    
                    //MARK: Below 3 Lines Of Code of .count To Check If Cart Is Empty Then Show Empty Cart Screen.
                    self.imgVwEmptyCart.isHidden = self.cartData?.product_list?.count ?? 0 < 1 ? false : true
                    self.lblItemNotFound.isHidden = self.cartData?.product_list?.count ?? 0 < 1 ? false : true
                    self.vwMain.isHidden = self.cartData?.product_list?.count ?? 0 < 1 ? true : false
                    
                    self.selectedAddressIndex = self.cartData?.address?.id ?? 0
                    self.lblAddress.text = "\(self.cartData?.address?.building_name ?? ""),\n\(self.cartData?.address?.street_name ?? ""),\n\(self.cartData?.address?.city ?? ""),\n\(self.cartData?.address?.pincode ?? 0)"
                    
                    print("GET CART DATA-->> \(response?.status ?? 0)")
                    
                    self.lblItemsInCart.text = "\(self.cartData?.product_list?.count ?? 0) \(self.cartData?.product_list?.count ?? 0 < 2 ? "item in cart" : "items in cart")"
                    
                    self.tblVw.reloadData()
                    self.collectionViewRecommendedProduct.reloadData()
                    DispatchQueue.main.async {
                        self.heightOfTblVw.constant = CGFloat((self.cartData?.product_list?.count ?? 0) * 360)
                        if let cartCount = response?.result?.cart_data?.total_cart_qty {
                            NotificationCenter.default.post(name: NSNotification.Name("updateCartCount"), object: cartCount)
                        }
                        self.viewWillLayoutSubviews()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.lblSomethingWentWrong.isHidden = false
                    Utilities.showPopup(title: response?.message ?? "", type: .Error)
                    print("GET CART DATA API ERROR ::> \(response?.message ?? "")")
                }
            }
        }
    }
    
    //MARK: REMOVE FROM CART API
    func removeFromCart(id: Int) {
        if !NetworkReachabilityManager()!.isReachable {
            return
        }
        
        let dict = ["cart_id": id]
        self.showLoading()
        APIManager.sharedManager.postData(url: APIManager.sharedManager.REMOVE_FROM_CART, parameters: dict ) { (response: ApiResponse?, error) in
            self.hideLoading()
            if response?.status == 200{
                DispatchQueue.main.async {
                    self.getCartData()
                    print("REMOVE FROM CART API ::> \(response?.message ?? "")")
                }
            }else{
                DispatchQueue.main.async {
                    Utilities.showPopup(title: response?.message ?? "", type: .Error)
                    print("REMOVE FROM CART API ERROR ::> \(response?.status ?? 0)")
                }
            }
            
        }
    }
    
    //MARK: GET INCENTIVES API
    //    func getIncentivePointsApi(){
    //        if !appDelegate.checkInternetConnection() {
    //            self.isRetryInternet { (isretry) in
    //                if isretry!{
    //                    self.getIncentivePointsApi()
    //                }
    //            }
    //            return
    //        }
    //        self.showLoading()
    //        APIManager.sharedManager.getData(url: APIManager.sharedManager.GET_INCENTIVE_POINTS, parameters: nil) { (response: ApiResponse?, error) in
    //            self.hideLoading()
    //            if response?.status == 200{
    //                DispatchQueue.main.async {
    //                    self.getPoints = response?.result?.user_data?.total_points ?? 0
    //                    self.lblTotalPoints.text = "\(self.getPoints) Points"
    //                }
    //            }else{
    //                DispatchQueue.main.async {
    //                    Utilities.showPopup(title: response?.message ?? "", type: .error)
    //                }
    //            }
    //        }
    //    }
    
    
}

//MARK: COLLECTION VIEW DELEGATE METHODS
extension CartViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartData?.top_deals_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealCollectionViewCell", for: indexPath) as! DealCollectionViewCell
        cell.index = indexPath.row
        cell.section = indexPath.section
        
        cell.quantityView.isHidden = false
        
        let topDealProducts = cartData?.top_deals_list![indexPath.row]
        
        if (topDealProducts?.cart_qty ?? 0)! == 0 {
            cell.btnMinus.isEnabled = false
            cell.btnMinus.setImage(UIImage(named: "minusGrayIcon"), for: .normal)
        }else {
            cell.btnMinus.isEnabled = true
            cell.btnMinus.setImage(UIImage(named: "minusIcon"), for: .normal)
        }
        
        
        cell.imgVwMedicines.setImage(imageUrl: topDealProducts?.photo?[0] ?? "")
        cell.lblMedicineName.text = topDealProducts?.title
        cell.lblQuantity.text = "\(topDealProducts?.cart_qty ?? 0)"
        cell.lblPtrPts.text = showPtrPts()
        
        cell.lblFreeQtyValue.text = "\(topDealProducts?.free_product_qty ?? 0)"
        cell.lblTotalQtyValue.text = "\(topDealProducts?.total_cart_qty ?? 0)"
        
        cell.lblFreeQty.isHidden = true
        cell.lblTotalQty.isHidden = true
        cell.lblFreeQtyValue.isHidden = true
        cell.lblTotalQtyValue.isHidden = true
        
        if topDealProducts?.discount_type == 3 {
            cell.lblFreeQty.isHidden = showHideLabel(cartQty: topDealProducts?.cart_free_qty)
            cell.lblTotalQty.isHidden = showHideLabel(cartQty: topDealProducts?.total_cart_qty)
            cell.lblFreeQtyValue.isHidden = showHideLabel(cartQty: topDealProducts?.cart_free_qty)
            cell.lblTotalQtyValue.isHidden = showHideLabel(cartQty: topDealProducts?.total_cart_qty)
        }
        cell.lblPrice.text = "Rs. \(topDealProducts?.price ?? "0.00")"
        cell.onPlusBtnClick = { [self] index, section in
            if(cartData?.top_deals_list?[index].discount_type == 3){
                self.sequence = (cartData?.top_deals_list?[index].sequence)! + 1
            }
            self.addToCart(productId: cartData?.top_deals_list?[index].id ?? 0 , quantity: cartData?.top_deals_list?[index].ratio ?? 1, sequenc: self.sequence) { [self] response in
                
                self.getCartData()
            }
        }
        
        cell.onMinusBtnClick = { [self] index, section in
            if(cartData?.top_deals_list?[index].cart_qty ?? 0 > 0) {
                let minusValue = Int("-\(cartData?.top_deals_list?[index].ratio ?? 0)") ?? 0
                print("MINUS VAL is:-  \(minusValue)")
                if(cartData?.top_deals_list?[index].discount_type == 3){
                    self.sequence = (cartData?.top_deals_list?[index].sequence)! - 1
                }
                self.addToCart(productId: cartData?.top_deals_list?[index].id ?? 0 , quantity: minusValue, sequenc: self.sequence) { [self] response in
                    
                    self.getCartData()
                }
            }
        }
        
        cell.lblRedOfferDiscount.isHidden = true
        if topDealProducts?.discount_type == 0 {
            cell.lblRedOfferDiscount.isHidden = true
            if let value = topDealProducts?.price {
                cell.lblPrice.text = "Rs.\(value)"
            }
        }else if (topDealProducts?.discount_type == 1){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = "  FLAT \(topDealProducts?.discount ?? "")\u{20B9} OFF  "
            if let value = topDealProducts?.final_price {
                cell.lblPrice.text = "Rs.\(value)"
            }
        }else if (topDealProducts?.discount_type == 2){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = "\(topDealProducts?.discount ?? "")% OFF"
            if let value = topDealProducts?.final_price {
                cell.lblPrice.text = "Rs.\(value)"
            }
        }else if (topDealProducts?.discount_type == 3){
            cell.lblRedOfferDiscount.isHidden = false
            cell.lblRedOfferDiscount.text = "  Buy \(topDealProducts?.product_qty ?? 0) Get \(topDealProducts?.free_product_qty ?? 0) Free   "
            if let value = topDealProducts?.price {
                cell.lblPrice.text = "Rs.\(value)"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height:350)
    }
}


extension CartViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.placeholder.returnColor() {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let currentString = (textView.text ?? "")
        let newString = currentString.trimmedString
        textView.text = newString
        if textView.text.isEmpty {
            textView.text = "Enter Additional Order Instructions"
            textView.textColor = Colors.placeholder.returnColor()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = (textView.text ?? "") as NSString
        let newString: String = currentString.replacingCharacters(in: range, with: text) as String
        return true
    }
}

