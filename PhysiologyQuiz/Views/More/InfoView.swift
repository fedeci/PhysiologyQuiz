//
//  InfoView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI
import StoreKit

struct SquaredIcon: View {
    private var isSystemIcon: Bool
    var icon: String
    
    init(systemIcon: String) {
        self.isSystemIcon = true
        self.icon = systemIcon
    }
    
    init(icon: String) {
        self.isSystemIcon = false
        self.icon = icon
    }

    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(5)
            (isSystemIcon
                ? Image(systemName: icon)
                : Image(icon))
                    .foregroundColor(.white)
        }
        .frame(width: 28, height: 28)
    }
}

struct InfoView: View {
    @State private var isShowingShareSheet = false
    @Binding var isShowingInfo: Bool

    var body: some View {
        NavigationView {
            List {
                Section("Contribuisci") {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        Button {
                            SKStoreReviewController.requestReview(in: windowScene)
                        } label: {
                            HStack {
                                SquaredIcon(systemIcon: "star.fill")
                                Text("Valuta")
                            }
                        }
                    }

                    Button {
                        isShowingShareSheet.toggle()
                    } label: {
                        HStack {
                            SquaredIcon(systemIcon: "square.and.arrow.up.fill")
                            Text("Condividi con gli amici")
                        }
                    }
                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/fedeci/PhysiologyQuiz/issues/new?assignees=&labels=bug&template=bug_report.md")!)
                    } label: {
                        HStack {
                            SquaredIcon(systemIcon: "ladybug.fill")
                            Text("Riporta un Bug")
                        }
                    }
                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/fedeci/PhysiologyQuiz/issues/new?assignees=&labels=quiz+request&template=quiz-request.md")!)
                    } label: {
                        HStack {
                            SquaredIcon(systemIcon: "plus")
                            Text("Aggiungi Quiz")
                        }
                    }
                }
                .listRowSeparator(.hidden)

                Section("Contatti") {
                    Button {
                        UIApplication.shared.open(emailURL())
                    } label: {
                        HStack {
                            SquaredIcon(systemIcon: "mail.fill")
                            Text("Email")
                        }
                    }

                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/fedeci")!)
                    } label: {
                        HStack {
                            SquaredIcon(icon: "github")
                            Text("GitHub")
                        }
                    }
                    
                    Button {
                        UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/federico-ciardi-190787222/")!)
                    } label: {
                        HStack {
                            SquaredIcon(icon: "linkedin")
                            Text("LinkedIn")
                        }
                    }
                    
                    Button {
                        if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
                            UIApplication.shared.open(URL(string: "twitter://user?screen_name=fedeci_")!)
                        } else {
                            UIApplication.shared.open(URL(string: "https://twitter.com/fedeci_")!)
                        }
                    } label: {
                        HStack {
                            SquaredIcon(icon: "twitter")
                            Text("Twitter")
                        }
                    }
                    
                    Button {
                        UIApplication.shared.open(URL(string: "https://www.instagram.com/fe.ciardi/")!)
                    } label: {
                        HStack {
                            SquaredIcon(icon: "instagram")
                            Text("Instagram")
                        }
                    }
                }
                .listRowSeparator(.hidden)
                
                Section("Legale") {
                    NavigationLink {
                        LicenseView()
                    } label: {
                        Text("Licenza")
                    }
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Text("Privacy Policy")
                    }
                    NavigationLink {
                        CreditsView()
                    } label: {
                        Text("Crediti")
                    }
                }
                .listRowSeparator(.hidden)

                Text("Versione: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowingInfo.toggle()
                    } label: {
                        Text("Fine")
                            .bold()
                    }
                }
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ActivityView(itemsToShare: [URL(string: "https://itunes.apple.com/us/app/keynote/id1634575286?mt=8")!])
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(isShowingInfo: .constant(true))
    }
}
