//
//  NAAlertView.swift
//  AppWayUser
//
//  Created by SOTSYS115 on 8/22/18.
//  Copyright © 2018 SOTSYS203. All rights reserved.
//

import UIKit

protocol NAAlertViewProtocol {
    func btnOkClicked(sender: UIButton)
}

class NAAlertView: UIView {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    var delegate: NAAlertViewProtocol!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addBehavior()
    }
    
    func addBehavior() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
        }
    }
    
    @IBAction func btnOkClicked(_ sender: UIButton) {
        delegate.btnOkClicked(sender: sender)
        self.removeFromSuperview()

    }
    
}
