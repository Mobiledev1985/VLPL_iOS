//
//  CartViewController.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit

class CartViewController: UIViewController {
    
    
    //-----------------------------
    // MARK:- Outlets Declaration-
    //-----------------------------
    
    @IBOutlet weak var lblItemsInCart: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtFieldPoints: UITextField!
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var btnApplyUI: UIButton!
    
    @IBOutlet weak var vwOrderConfirm: UIView!
    @IBOutlet weak var btnOrderConfirmUI: UIButton!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var vwPaymentDetails: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var heightOfTblVw: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgVwEmptyCart: UIImageView!
    @IBOutlet weak var lblItemNotFound: UILabel!
    @IBOutlet weak var lblSomethingWentWrong: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var widthBtnBack: NSLayoutConstraint!
    @IBOutlet weak var vwBackGround: UIView!
    @IBOutlet weak var additionalInstructionTextView: UITextView!
    
    //Mr Details VIEW
    @IBOutlet weak var lblUserTitle: UILabel!
    @IBOutlet weak var mrDetailsView: UIView!
    @IBOutlet weak var lblMrName: UILabel!
    @IBOutlet weak var lblMrEmail: UILabel!
    @IBOutlet weak var lblMrMobileNumber: UILabel!
    
    //Stokiest Detail View
    @IBOutlet weak var stokiestDetailView:UIView!
    @IBOutlet weak var lblStokiestName: UILabel!
    @IBOutlet weak var lblStokiestEmail: UILabel!
    @IBOutlet weak var lblStokiestNumber: UILabel!
    @IBOutlet weak var collectionViewRecommendedProduct: UICollectionView!
    
    
    //------------------------------
    // MARK:- Variables Declaration-
    //------------------------------
    
    var paymentDetailsView = PaymentDetailsView()
    var cartData : CartProduct?
    
    var selectedAddressIndex = 0
    var sequence = 0
    
    var cartQtyToSent = 0
    var productQtyToSent = 0
    var productSlugInCart = ""
    
    var getAppliedPoints = 0
    var userEnteredPoint = 0
    var isBackBtnHide = false
    var onClickBack: ((Int,Int)->Void)?
    
    
    //-------------------------------
    // MARK:- View LifeCycle Methods-
    //-------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPaymentDetailsView()
        // Load XIB
        tblVw.register(UINib(nibName: "NewSearchMedicineTblVwCell", bundle: nil), forCellReuseIdentifier: "NewSearchMedicineTblVwCell")
        collectionViewRecommendedProduct.register(UINib(nibName: "DealCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DealCollectionViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartData()
    }
    
    //MARK:- OUTLET of TABLEVIEW HEIGHT is taken and is used below to Set Height of TableView DYNAMIC
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightOfTblVw.constant = self.tblVw.contentSize.height
    }
    
    func reloadTableView() {
        self.tblVw.reloadData()
    }
    
    //-----------------------
    // MARK:- Custom Methods-
    //-----------------------
    
    func setupUI() {
        additionalInstructionTextView.layer.cornerRadius = 10
        additionalInstructionTextView.text = "Enter Additional Order Instructions"
        additionalInstructionTextView.textColor = Colors.placeholder.returnColor()
        if isBackBtnHide == true{
            btnBack.isHidden = true
            widthBtnBack.constant = 0
        }
        let role = APIManager.sharedManager.user?.roleName
        
        if role == "MR" {
            self.btnOrderConfirmUI.isHidden = true
        } else {
            self.btnOrderConfirmUI.isHidden = false
        }
        
        txtFieldPoints.layer.borderWidth = 1
        txtFieldPoints.layer.borderColor = Colors.lightGray.returnColor().cgColor
        txtFieldPoints.layer.cornerRadius = 6
        btnApplyUI.layer.cornerRadius = 6
        btnOrderConfirmUI.layer.cornerRadius = 6
        vwOrderConfirm.layer.shadowColor = UIColor.lightGray.cgColor
        vwOrderConfirm.layer.shadowOffset = CGSize(width: 3, height: 3)
        vwOrderConfirm.layer.shadowOpacity = 0.9
        vwOrderConfirm.layer.masksToBounds = false
        vwMain.isHidden = true
        lblSomethingWentWrong.isHidden = true
    }
    
    func setupPaymentDetailsView() {
        paymentDetailsView = PaymentDetailsView.instantiate(title: "Payment Details")
        paymentDetailsView.frame = CGRect(x: 0, y: 0, width: self.vwPaymentDetails.layer.frame.width, height:self.vwPaymentDetails.layer.frame.height)
        paymentDetailsView.lblMRPTitle.text = getPtrPtsStatus() + " Amount"
        paymentDetailsView.lblMRPTotal.text = "Rs. 0.00"
        paymentDetailsView.lblGST.text = "Rs. 0.00"
        paymentDetailsView.lblProductPoints.text = "-Rs. 0.00"
        paymentDetailsView.lblTotalPrice.text = "Rs. 0.00"
        self.vwPaymentDetails.addSubview(paymentDetailsView)
    }
    
    //MARK: APPLY POINTS API
    func applyPoints(){
        if !NetworkReachabilityManager()!.isReachable {
            isRetryInternet() { (isretry) in
                if isretry! {
                    self.applyPoints()
                }
            }
            return
        }
        
        let dict = ["points": txtFieldPoints.text ?? 0] as [String: Any]
        
        self.showLoading()
        APIManager.sharedManager.postData(url: APIManager.sharedManager.APPLY_POINTS, parameters: dict) { (response: ApiResponse?, error) in
            self.hideLoading()
            if response?.status == 200 {
                DispatchQueue.main.async {
                    
                    self.getAppliedPoints = (response?.result?.apply_points?.amount ?? 0)
                    
                    self.paymentDetailsView.lblTotalPrice.text = "Rs. \((Double(self.cartData?.total_amount ?? "0.0") ?? 0.0) - Double(self.getAppliedPoints))"
                    self.lblTotalAmount.text = "Rs. \((Double(self.cartData?.total_amount ?? "0.0") ?? 0.0) - Double(self.getAppliedPoints))"
                    
                    self.lblTotalPoints.text = "\((self.cartData?.total_incentive_points ?? 0) - Int((self.txtFieldPoints.text ?? "0") as String)!) Points"
                    self.txtFieldPoints.text = ""
                    self.paymentDetailsView.lblProductPoints.text = String(format: "-Rs. %.2f", self.getAppliedPoints)
                    
                }
            } else {
                Utilities.showPopup(title: response?.message ?? "", type: .Error)
            }
        }
        return
    }
    
    //----------------
    // MARK:- Actions-
    //----------------
    
    @IBAction func onClickBtnApply(_ sender: UIButton) {
        
        // DO NOT DELETE THIS BELOW CODE ITS IN *****IMPORTANT*****
        userEnteredPoint = Int(txtFieldPoints.text ?? "") ?? 0
        
        if(self.txtFieldPoints.text) == ""{
            if(self.cartData?.total_incentive_points == 0){
                self.showToast(message: "You don't have enough points.", seconds: 2.0)
            }else{
                self.showToast(message: "Please enter incentives from \(self.cartData?.total_incentive_points ?? 0) points", seconds: 2.0)
            }
        }else if (userEnteredPoint == 0){
            self.showToast(message: "Please enter valid points", seconds: 2.0)
        }else{
            if userEnteredPoint > self.cartData?.total_incentive_points ?? 0 {
                self.showToast(message: "Enter below \(self.cartData?.total_incentive_points ?? 0)", seconds: 2.0)
                print("Points more entered")
                
            }else{
                print("entered points are:- \(txtFieldPoints.text!)")
            }
            //MARK: APPLY POINTS API CALLED HERE
            applyPoints()
        }
    }
    
    @IBAction func onClickOrderConfirmBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

