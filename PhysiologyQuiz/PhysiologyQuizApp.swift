//
//  PhysiologyQuizApp.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds

@main
struct PhysiologyQuizApp: App {
    var updates: Task<Void, Never>? = nil

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification)) { _ in
                    Task {
                        await tryLoadAds()
                    }
                }
        }
    }
    
    private func tryLoadAds() async {
        await ATTrackingManager.requestTrackingAuthorization()

        await GADMobileAds.sharedInstance().start()
    }
}
