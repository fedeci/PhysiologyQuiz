//
//  SettingsView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 12/07/22.
//

import SwiftUI
import StoreKit
import UserMessagingPlatform

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.blue)
            .foregroundStyle(.white)
            .font(.body.bold())
            .clipShape(Capsule())
    }
}

struct SettingsView: View {
    @State private var isBuyingAdRemoval = false
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var appStore: AppStoreViewModel
    
    var body: some View {
        List {
            Section("Numero di domande") {
                Stepper(value: viewModel.settings.$numberOfQuestions, in: 1...200) {
                    Text("Numero di domande: \(viewModel.settings.numberOfQuestions)")
                }
            }
            Section("Punteggi") {
                Stepper(value: viewModel.settings.$correctAnswer, in: 0...2, step: 0.05) {
                    Text("Punteggio risposte corrette: \(viewModel.settings.correctAnswer, specifier: "%.2f")")
                }
                Stepper(value: viewModel.settings.$wrongAnswer, in: -2...2, step: 0.05) {
                    Text(String(format: "Punteggio risposte errate: %.2f", viewModel.settings.wrongAnswer))
                }
                Stepper(value: viewModel.settings.$nonGivenAnswer, in: -2...2, step: 0.05) {
                    Text(String(format: "Punteggio risposte non date: %.2f", viewModel.settings.nonGivenAnswer))
                }
            }
            
            if let adRemovalProduct = appStore.adRemovalProduct {
                if !appStore.didRemoveAds {
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Rimuovi pubblicità")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                Spacer()
                                Button {
                                    Task {
                                        isBuyingAdRemoval = true
                                        try await appStore.purchaseAdRemoval()
                                        isBuyingAdRemoval = false
                                    }
                                } label: {
                                    ZStack {
                                        Text(adRemovalProduct.displayPrice)
                                            .foregroundStyle(isBuyingAdRemoval ? .clear : .white)
                                        if isBuyingAdRemoval {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                                .environment(\.colorScheme, .dark)
                                        }
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.blue)
                                .font(.body.bold())
                                .clipShape(Capsule())
                                .buttonStyle(BorderlessButtonStyle())
                                .disabled(isBuyingAdRemoval)
                            }
                            Text("Rimuove tutte le pubblicità dall'app e supporta lo sviluppatore 🥳❤️")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .padding(.top, 2)
                        }
                        Button("Ripristina acquisto") {
                            Task {
                                await appStore.updateCustomerProductStatus()
                            }
                        }
                        .disabled(isBuyingAdRemoval)
                    }
                } else {
                    Section {
                        HStack {
                            Text("Pubblicità rimosse")
                                .fontWeight(.medium)
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.green, .green.opacity(0.65))
                                .font(.title2)
                        }
                    }
                }
            }
            
            if UMPConsentInformation.sharedInstance.privacyOptionsRequirementStatus != .notRequired || appStore.didRemoveAds {
                Section {
                    Button("Gestisci consensi di Google AdMob") {
                        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let root = scene.windows.first?.rootViewController
                        else { return }
                        Task {
                            try await UMPConsentForm.presentPrivacyOptionsForm(from: root)
                        }
                    }
                }
            }
        }
        .navigationTitle(Text("Impostazioni"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel("questions", "json"))
            .environmentObject(AppStoreViewModel())
    }
}
