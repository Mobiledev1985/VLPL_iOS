//
//  NoInternetConnectionVC.swift
//  - To represent "No Internet" screen which will be displayed when Internet connection lost.

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    // MARK: - Variables
    var onTappedRetry:(() ->  Void)?
    
    // MARK: - Controls
    @IBOutlet weak var btnRetry: UIButton!
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRetry.roundCorners(corners: .allCorners, radius: 10)
    }
    
    // MARK: - Button Click Events
    
    // Check internet connectivity again
    @IBAction func onClickRetry(_ sender: Any) {
        if !NetworkReachabilityManager()!.isReachable {
            return
        }
        
        onTappedRetry!()
        self.dismiss(animated: true, completion: nil)
    }
}
