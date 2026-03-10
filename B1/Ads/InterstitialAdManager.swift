//
//  InterstitialAdManager.swift
//  B1
//
//  Created by Đinh Văn Phi on 10/3/26.
//

import Foundation
import GoogleMobileAds
import UIKit
@MainActor
class InterstitialAdManager: NSObject {
    
    static let shared = InterstitialAdManager()
    
    private var interstitialAd: InterstitialAd?
    
    // Test Ad Unit ID
    private let adUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    private override init() {
        super.init()
    }
    
    // MARK: - Load Ad
    func loadAd() {
        
        let request = Request()
        
        InterstitialAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            
            if let error = error {
                print(" Failed to load Interstitial Ad: \(error.localizedDescription)")
                return
            }
            
            self?.interstitialAd = ad
            self?.interstitialAd?.fullScreenContentDelegate = self
            
            print("Interstitial Ad Loaded")
        }
    }
    
    // MARK: - Show Ad
    func showAd(from viewController: UIViewController) {
        
        guard let interstitialAd = interstitialAd else {
            print(" Interstitial Ad not ready")
            return
        }
        
        interstitialAd.present(from: viewController)
    }
}

extension InterstitialAdManager: FullScreenContentDelegate {
    
    // Called when ad is dismissed
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Interstitial Ad dismissed")
        
        // Load next ad
        loadAd()
    }
    
    func ad(_ ad: FullScreenPresentingAd,
            didFailToPresentFullScreenContentWithError error: Error) {
        
        print(" Failed to present ad: \(error.localizedDescription)")
        
        // Reload ad
        loadAd()
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print(" Interstitial Ad will present")
    }
}
