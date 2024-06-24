//
//  UIViewController+Extension.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func resizeImage(image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        
        //MARK: GET COMPRESSED IMAGE SIZE OF IMAGE FROM CAMERA AND GALLERY
        let imgSize: Int = imageData?.count ?? 0
        print("actual size of image in KB: %f ", Double(imgSize) / 1000.0)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }
    
    func showPtrPts() -> String {
//        if UserDefaults.standard.value(forKey: UserDefaultType.userRoleType) as? String == "Stockist"{
//            return "PTS Price"
//        }else{
//            return "PTR Price"
//        }
        return "Your Price*"
    }
    
    func getPtrPtsStatus() -> String {
        if UserDefaults.standard.value(forKey: UserDefaultType.userRoleType) as? String == "Stockist"{
            return "PTS"
        }else{
            return "PTR"
        }
    }
    
    func showHideLabel(cartQty: Int?) -> Bool{
        if cartQty == 0{
            return true
        }else{
            return false
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.show(animated: true)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
//MARK: SHOW TOAST MESSAGE
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .lightGray
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 10
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    // Retry for an Internet Connection
    func isRetryInternet(completion: @escaping (_ isRetry: Bool?) -> Void) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "NoInternetConnectionVC") as! NoInternetConnectionVC
        objVC.modalPresentationStyle = .overCurrentContext
        objVC.modalTransitionStyle = .crossDissolve
        objVC.onTappedRetry = {
            completion(true)
        }
        self.present(objVC, animated: true, completion: nil)
    }
    
    func addToCart(productId: Int, quantity: Int, sequenc: Int, completion : @escaping ((_ response : ApiResponse) -> ())){
        if !NetworkReachabilityManager()!.isReachable {
            isRetryInternet() { (isretry) in
                if isretry! {
                    self.addToCart(productId: productId, quantity: quantity, sequenc: sequenc, completion: completion)
                }
            }
            return
        }

        let dict = ["product_id": productId, "quantity": quantity, "sequence": sequenc]
        
        self.showLoading()
        APIManager.sharedManager.postData(url: APIManager.sharedManager.ADD_TO_CART, parameters: dict) { (response: ApiResponse?, error) in
            self.hideLoading()
            if response?.status == 200 {
                DispatchQueue.main.async {
                    completion(response!)
                }
            } else {
                Utilities.showPopup(title: response?.message ?? "", type: .Error)
            }
        }
        return
    }
}
