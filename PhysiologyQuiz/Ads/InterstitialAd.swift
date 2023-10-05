//
//  InterstitialAd.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 04/10/23.
//

import GoogleMobileAds
import SwiftUI
import UIKit

#if DEBUG
let adUnitID = "ca-app-pub-3940256099942544/4411468910"
#else
let adUnitID = "ca-app-pub-6770476712372706/4309124175"
#endif

final class InterstitialAd: NSObject, GADFullScreenContentDelegate {
    static let shared = InterstitialAd()

    var interstitialAd: GADInterstitialAd?
    
    override init() {
        super.init()
        loadInterstitial()
    }
    
    private func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adUnitID,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        })
    }
    
    func present() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let root = windowScene.windows.first?.rootViewController else { return }
        interstitialAd?.present(fromRootViewController: root)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadInterstitial()
    }
}
