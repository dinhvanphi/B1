import UIKit
import GoogleMobileAds

class InterstitialAdManager: NSObject, FullScreenContentDelegate {
    
    static let shared = InterstitialAdManager()
    
    private var interstitial: InterstitialAd?
    private var onAdDismissed: (() -> Void)?  		
    
    var isAdReady: Bool {
        return interstitial != nil
    }
    
    // Load ad
    func loadAd() {
        Task {
            do {
                interstitial = try await InterstitialAd.load(
                    with: "ca-app-pub-3940256099942544/4411468910",
                    request: Request())
                interstitial?.fullScreenContentDelegate = self
            } catch {
                print("Failed to load ad: \(error.localizedDescription)")
            }
        }
    }
    
   
    func showAd(from viewController: UIViewController, onDismissed: @escaping () -> Void) {
        guard let ad = interstitial else {
            onDismissed()
            return
        }
        self.onAdDismissed = onDismissed
        ad.present(from: viewController)
    }
    
    
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        interstitial = nil
        onAdDismissed?()
        onAdDismissed = nil
    }
    
    func ad(_ ad: FullScreenPresentingAd,
            didFailToPresentFullScreenContentWithError error: Error) {
        interstitial = nil
        onAdDismissed?()
        onAdDismissed = nil
    }
}
