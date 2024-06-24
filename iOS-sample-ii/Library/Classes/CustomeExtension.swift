//
//  CustomeExtension.swift
//  AircraftApp
//
//  Created by SOTSYS148 on 19/02/20.
//  Copyright © 2020 SOTSYS203. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func displayNavigationBar(isLargeTitleVisible:Bool? = true,titlecolor: UIColor? = UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1))
    {
        //self.isNavBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = isLargeTitleVisible!
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 0
        let attrsLarge = [NSAttributedString.Key.foregroundColor: UIColor.black,
                          NSAttributedString.Key.font: UIFont.mediumFont(ofSize: 33.0),
                          NSAttributedString.Key.paragraphStyle : style]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrsLarge as [NSAttributedString.Key : Any]
        let attrs = [
            NSAttributedString.Key.foregroundColor: titlecolor!,
            NSAttributedString.Key.font: UIFont.normalFont(ofSize: 17.0)
        ]
        
        
        self.navigationController?.navigationBar.titleTextAttributes = attrs
    }
    
    func setLeftBarButtonTitle(imageName: UIImage, selector:Selector)
    {
        let backBtn: UIButton = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)//CGRectMake(0, 0, 40, 40)
        backBtn.setImage(imageName, for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//        backBtn .contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        backBtn.addTarget(self, action: selector, for: .touchUpInside)
        let backButton: UIBarButtonItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setSegmentControlOnTopBar(items:[String], selector: Selector,segmentIndex:Int){
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = segmentIndex
        customSC.backgroundColor = .green
        customSC.tintColor =  UIColor.white
        customSC.borderColor = UIColor.white
        customSC.width = 140.0
        customSC.borderWidth = 1.0
        let font = UIFont.mediumFont(ofSize: 15.0)
        customSC.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        customSC.addTarget(self, action:selector, for: .valueChanged)
        self.navigationItem.titleView = customSC
    }
    
    func setRightBarBtn(imageName: UIImage, selector:Selector){
        let firstBtn: UIButton = UIButton(type: .custom)
        firstBtn.frame = CGRect(x: 50, y: 0, width: 40, height: 40)//CGRectMake(0, 0, 40, 40)
        firstBtn.setImage(imageName, for: .normal)
        firstBtn.addTarget(self, action: selector, for: .touchUpInside)
        let firstButton: UIBarButtonItem = UIBarButtonItem(customView: firstBtn)
        self.navigationItem.rightBarButtonItem = firstButton
    }
    
    func setRightBarBtnTitle(strTitle:String,selectorMethod:Selector){
        let firstBtn: UIButton = UIButton(type: .custom)
        firstBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 20)//CGRectMake(0, 0, 40, 40)
        firstBtn.setTitle(strTitle, for: .normal)
        firstBtn.setTitleColor(UIColor.white, for: .normal)
        firstBtn.titleLabel?.font = UIFont.mediumFont(ofSize: 17.0)
        firstBtn.addTarget(self, action: selectorMethod, for: .touchUpInside)
        let firstButton: UIBarButtonItem = UIBarButtonItem(customView: firstBtn)
        self.navigationItem.rightBarButtonItem = firstButton
    }
    
    func applyShadow(view: UIView, shadowColor : CGColor, radius : CGFloat, offset: CGSize? = CGSize(width: 0, height: 0)) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = offset ?? CGSize(width: 0 , height:0)
    }

    func timeStringFromUnixTime(unixTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString //dateFormatter.stringFromDate(date)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString //dateFormatter.stringFromDate(date)
    }
    
    func imagetoData(url: String) -> Data {
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
            return data!
    }
}
