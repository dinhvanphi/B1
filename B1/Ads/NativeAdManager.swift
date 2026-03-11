import UIKit
import GoogleMobileAds

class NativeAdManager: NSObject, NativeAdLoaderDelegate {
    
    static let shared = NativeAdManager()
    
    private var adLoader: AdLoader?
    var nativeAd: NativeAd?
    var onAdLoaded: (() -> Void)?
    
    func loadAd() {
        adLoader = AdLoader(
            adUnitID: "ca-app-pub-3940256099942544/3986624511",
            rootViewController: nil,
            adTypes: [.native],
            options: nil)
        adLoader?.delegate = self
        adLoader?.load(Request())
    }
    
    // MARK: - NativeAdLoaderDelegate
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        print(" Native Ad loaded")
        self.nativeAd = nativeAd
        onAdLoaded?()
    }
    
    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
        print(" Native Ad failed: \(error.localizedDescription)")
    }
}
