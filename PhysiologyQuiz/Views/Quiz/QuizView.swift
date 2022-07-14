//
//  QuizView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct QuizView: View {
    @State private var isShowingResults: Bool = false
    @State private var isShowingResultsSheet: Bool = false
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            AnswersSummaryView(viewModel: viewModel, isShowingCorrection: $isShowingResults)
            VStack {
                Spacer()
                Text(viewModel.currentQuestion.question)
                    .bold()
                    .padding()
                    .font(.system(size: 24))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    isShowingResultsSheet.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(
                                isShowingResults ? .blue : .clear
                            )
                            .frame(height: 50.0)
                            .cornerRadius(16)
                        Text("Mostra punteggi")
                            .foregroundColor(
                                isShowingResults
                                ? .white
                                : .clear
                            )
                            .bold()

                    }
                }
                    .disabled(!isShowingResults)
                    .accessibilityAddTraits([.isButton])
                    .accessibilityIdentifier("showResultsButton")
                HStack {
                    Button {
                        viewModel.answerQuestionAt(value: false)
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(
                                    (viewModel.currentQuestion.value ?? true)
                                    ? Color(uiColor: .systemGray6)
                                    : .red
                                )
                                .frame(height: 50.0)
                                .cornerRadius(16)
                            Image(systemName: "multiply")
                                .resizable()
                                .font(.body.weight(.semibold))
                                .foregroundColor(
                                    (viewModel.currentQuestion.value ?? true)
                                    ? .red
                                    : .white
                                )
                                .frame(width: 24, height: 24)
                        }
                    }
                        .disabled(isShowingResults)
                        .accessibilityAddTraits([.isButton])
                        .accessibilityIdentifier("falseButton")
                    Spacer()
                    Button {
                        viewModel.answerQuestionAt(value: true)
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(
                                    !(viewModel.currentQuestion.value ?? false)
                                    ? Color(uiColor: .systemGray6)
                                    : .green
                                )
                                .frame(height: 50.0)
                                .cornerRadius(16)
                            Image(systemName: "checkmark")
                                .resizable()
                                .font(.body.weight(.semibold))
                                .foregroundColor(
                                    !(viewModel.currentQuestion.value ?? false)
                                    ? .green
                                    : .white
                                )
                                .frame(width: 24, height: 24)
                        }
                    }
                        .disabled(isShowingResults)
                        .accessibilityAddTraits([.isButton])
                        .accessibilityIdentifier("trueButton")
                }
                .padding(.top)
            }
            .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local).onEnded { value in
                if value.startLocation.x > value.location.x {
                    // swipe to left
                    viewModel.skipQuestions(1)
                } else {
                    viewModel.skipQuestions(-1)
                }
            })
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Text("\(viewModel.counter + 1) / \(viewModel.settings.numberOfQuestions)")
                        .bold()
                    Button {
                        isShowingResults ? viewModel.resetQuiz() : print("show solutions here")
                        isShowingResults.toggle()
                    } label: {
                        Image(systemName: isShowingResults ? "arrow.counterclockwise.circle.fill" : "forward.end.fill")
                    }
                        .accessibilityAddTraits([.isButton])
                        .accessibilityIdentifier(isShowingResults ? "restartButton" : "submitButton")
                }
            }
            .sheet(isPresented: $isShowingResultsSheet) {
                ResultsView(isShowingSheet: $isShowingResultsSheet, viewModel: viewModel)
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(viewModel: ViewModel("questions", "json"))
    }
}
