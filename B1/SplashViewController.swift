//
//  SplashViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 10/3/26.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
       
        InterstitialAdManager.shared.loadAd()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showAd()
        }
    }
    
    func showAd() {
        InterstitialAdManager.shared.showAd(from: self)
    }
}
