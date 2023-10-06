//
//  PhysiologyQuizApp.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import UserMessagingPlatform

@main
struct PhysiologyQuizApp: App {
    @StateObject private var appStore = AppStoreViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    Task {
                        await loadAds()
                    }
                }
                .environmentObject(appStore)
        }
    }
    
    @MainActor
    private func requestUserConsent(from controller: UIViewController) async throws {
        let parameters = UMPRequestParameters()
//        #if DEBUG
//        let debugSettings = UMPDebugSettings()
//        debugSettings.geography = .EEA
//        parameters.debugSettings = debugSettings
//        UMPConsentInformation.sharedInstance.reset()
//        #endif

        try await UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters)

        try await UMPConsentForm.loadAndPresentIfRequired(from: controller)
    }
    
    @MainActor
    private func loadAds() async {
        await appStore.initializeStore()
        
        if !appStore.didRemoveAds {
            await ATTrackingManager.requestTrackingAuthorization()
            
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let root = scene.windows.first?.rootViewController else { return }
            
            try? await requestUserConsent(from: root)
            
            if UMPConsentInformation.sharedInstance.canRequestAds {
                await GADMobileAds.sharedInstance().start()
                
                InterstitialAd.shared.loadInterstitial()
            }
        }
    }
}
