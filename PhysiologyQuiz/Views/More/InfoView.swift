//
//  InfoView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct InfoView: View {
    @Binding var isShowingInfo: Bool

    func emailURL(subject: String = "") -> URL {
        let _subject = "Quiz fisiologia" + (subject.count > 0 ? "- \(subject)" : subject)
        return URL(string: "mailto:fed.ciardi+quiz-fisiologia@gmail.com?subject=\(_subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
    }

    var body: some View {
        NavigationView {

            List {
                Section("Contribuisci") {
                    Button {
                        UIApplication.shared.open(emailURL(subject: "Quiz"))
                    } label: {
                        HStack {
                            Image(systemName: "star")
                            Text("Valuta")
                        }
                    }
                    Button {
                        UIApplication.shared.open(emailURL(subject: "Quiz"))
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Condividi")
                        }
                    }
                    Button {
                        UIApplication.shared.open(emailURL(subject: "Quiz"))
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Proponi altri quiz")
                        }
                    }
                }
                .listRowSeparator(.hidden)

                Section("Legale") {
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Image(systemName: "lock.fill")
                        Text("Privacy Policy")
                    }
                }
                .listRowSeparator(.hidden)

                Section("Contatti") {
                    Button {
                        UIApplication.shared.open(emailURL())
                    } label: {
                        HStack {
                            Image(systemName: "mail.fill")
                            Text("Email")
                        }
                    }

                }
                .listRowSeparator(.hidden)

                Section("Autore") {
                    Text("Versione")
                    Text("Versione")
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
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(isShowingInfo: .constant(true))
    }
}
