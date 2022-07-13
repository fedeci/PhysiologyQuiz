//
//  ContentView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel("questions", "json")
    @State private var isShowingInfo = false
    @State private var isShowingQuestions = false

    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                Image("research")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                Spacer()
                VStack {
                    NavigationLink {
                        QuizView(viewModel: viewModel)
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color("AccentColor"))
                                .frame(height: 60.0)
                                .cornerRadius(16)
                            Text("Inizia")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.resetQuiz()
                    })
                }
                .padding()
            }
            .navigationTitle("Quiz fisiologia")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        isShowingInfo.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigation) {
                    NavigationLink {
                        SettingsView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                ToolbarItem {
                    Button {
                        isShowingQuestions.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
            .sheet(isPresented: $isShowingInfo) {
                InfoView(isShowingInfo: $isShowingInfo)
            }
            .sheet(isPresented: $isShowingQuestions) {
                AllQuestionsView(isShowingQuestions: $isShowingQuestions, viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
