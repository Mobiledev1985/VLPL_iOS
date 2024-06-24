//
//  AppSingleton.swift
//  AircraftApp
//
//  Created by SOTSYS148 on 04/03/20.
//  Copyright © 2020 SOTSYS203. All rights reserved.
//

import UIKit

@objc class AppSingleton: NSObject {
    static var instance: AppSingleton!
    var vSpinner : UIView?
    class func shared() -> AppSingleton {
        self.instance = (self.instance ?? AppSingleton())
        return self.instance
    }
    
    func loadNib(nibName:String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func getCurrentTimeStamp() -> String {
        let df = DateFormatter()
        let date = NSDate()
        df.dateFormat = "yyyyMMddhhmmss"
        let NewDate = df.string(from: date as Date)
        return NewDate.replacingOccurrences(of: ":", with: "")
    }
    
    func showNoRecordPopView()-> CustomNoRecordFoundView {
        var objPopup = CustomNoRecordFoundView()
        objPopup = self.loadNib(nibName: NCustomNoRecordFoundView) as! CustomNoRecordFoundView
        return objPopup
    }
    
    //MARK: Create Token
    func createHashedTokenString(timeStemp : String , randomStr :  String) -> String {
        var str = String(format: "%@=%@&%@=%@","nonce", randomStr, "timestamp",timeStemp)
        
        str = str.appending("|")
        str = str.appending(kSecret)
        str = str.hmac(algorithm: .SHA256, key:kPrivateKey)
        return str
    }
    
    func isValidPhoneNumber(strPhone:String) -> Bool {
        let phoneRegex = "^[0-9]*$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@",phoneRegex)
        return phoneTest.evaluate(with: strPhone)
    }
    
    func tokenGeneratedMethod() -> TokenGenerate {
        let obj = TokenGenerate()
        obj.nonce = 6.randomString
        obj.timestamp = AppSingleton.shared().getCurrentTimeStamp()
        obj.token = AppSingleton.shared().createHashedTokenString(timeStemp: obj.timestamp, randomStr: obj.nonce)
        TokenGenerate.sharedToken = obj
        return obj
    }
    
    func startLoadingForSideMenuScreen(inView:UIView?){
        let viewTransparent = UIView()
        viewTransparent.frame = CGRect(x: 0, y: 0, width: WINDOW_WIDTH, height: WINDOW_HEIGHT)
        viewTransparent.tag = NLoadingViewTag
        viewTransparent.backgroundColor = UIColor.black.withAlphaComponent(0.5) //0.5
        
        AppDelegate.shared.window?.addSubview(viewTransparent)
        
        let viewTransparent1 = UIView()
        viewTransparent1.frame = CGRect(x: 0, y: 64, width: WINDOW_WIDTH, height: WINDOW_HEIGHT)
        viewTransparent1.backgroundColor = UIColor.white.withAlphaComponent(1.0) //0.5
        //        viewTransparent.addSubview(viewTransparent1)
        
        let appLogo = UIImageView(image: #imageLiteral(resourceName: "icn_applogo-1")) //AppLogo //logo_spinner_white
        appLogo.frame = CGRect(x: 0, y: 0, width: 30 ,height: 30)
        appLogo.center = CGPoint(x: WINDOW_WIDTH/2.0, y: WINDOW_HEIGHT/2.0)
        viewTransparent.addSubview(appLogo)
        
        let imgViewRing = UIImageView(image: #imageLiteral(resourceName: "icn_radio_btn"))
        if DeviceType.IS_IPHONE_5{
            imgViewRing.frame = CGRect(x: 0, y: 0, width: #imageLiteral(resourceName: "icn_radio_btn").size.width - 10, height: #imageLiteral(resourceName: "icn_radio_btn").size.height - 10)
        }else{
            imgViewRing.frame = CGRect(x: 0, y: 0, width: #imageLiteral(resourceName: "icn_radio_btn").size.width, height: #imageLiteral(resourceName: "icn_radio_btn").size.height)
        }
        imgViewRing.center = CGPoint(x: WINDOW_WIDTH/2.0, y: WINDOW_HEIGHT/2.0)
        imgViewRing.rotateAnimation()
        viewTransparent.addSubview(imgViewRing)
    }
    
    func startLoading(inView:UIView?) {
        let viewTransparent = UIView()
        viewTransparent.frame = CGRect(x: 0, y: 0, width: WINDOW_WIDTH, height: WINDOW_HEIGHT)
        viewTransparent.tag = NLoadingViewTag
        viewTransparent.backgroundColor = UIColor.black.withAlphaComponent(0.5) //0.5
        //        if inView != nil{
        //            inView?.addSubview(viewTransparent)
        //        }else{
        AppDelegate.shared.window?.addSubview(viewTransparent)
        //        }
        
        let viewTransparent1 = UIView()
        viewTransparent1.frame = CGRect(x: 0, y: 64, width: WINDOW_WIDTH, height: WINDOW_HEIGHT)
        viewTransparent1.backgroundColor = UIColor.white.withAlphaComponent(1.0) //0.5
        //        viewTransparent.addSubview(viewTransparent1)
        
        let appLogo = UIImageView(image: #imageLiteral(resourceName: "icn_applogo-1")) //AppLogo //logo_spinner_white
        appLogo.frame = CGRect(x: 0, y: 0, width: 30 ,height: 30)
        appLogo.center = CGPoint(x: WINDOW_WIDTH/2.0, y: WINDOW_HEIGHT/2.0)
        viewTransparent.addSubview(appLogo)
        
        let imgViewRing = UIImageView(image: #imageLiteral(resourceName: "icn_radio_btn"))
        if DeviceType.IS_IPHONE_5{
            imgViewRing.frame = CGRect(x: 0, y: 0, width: #imageLiteral(resourceName: "icn_radio_btn").size.width - 10, height: #imageLiteral(resourceName: "icn_radio_btn").size.height - 10)
        }else{
            imgViewRing.frame = CGRect(x: 0, y: 0, width: #imageLiteral(resourceName: "icn_radio_btn").size.width, height: #imageLiteral(resourceName: "icn_radio_btn").size.height)
        }
        imgViewRing.center = CGPoint(x: WINDOW_WIDTH/2.0, y: WINDOW_HEIGHT/2.0)
        imgViewRing.rotateAnimation()
        viewTransparent.addSubview(imgViewRing)
    }
    
    
    func stopLoading(inView:UIView?) {
        //        if inView != nil{
        //            let viewLoading = inView?.viewWithTag(NLoadingViewTag)
        //            viewLoading?.removeFromSuperview()
        //        }else{
        let viewLoading = AppDelegate.shared.window?.viewWithTag(NLoadingViewTag)
        viewLoading?.removeFromSuperview()
        //        }
    }
    
    
    ///////////////////////////////////////
    // MARK: User info Save and Retrive
    ///////////////////////////////////////
    
//    func saveToLocal(rootObject:LoginResponseData) {
//        do{
//            let data = try NSKeyedArchiver.archivedData(withRootObject: JSONEncoder().encode(rootObject))
//            UserDefaults.standard.set(data, forKey: "UserDM")
//        }catch {
//            print(error)
//        }
//        UserDefaults.standard.synchronize()
//    }
    
    
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        self.vSpinner?.removeFromSuperview()
        self.vSpinner = nil
    }
}
