//
//  AnswersSummaryView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct AnswersSummaryView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var isShowingCorrection: Bool

    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<viewModel.settings.numberOfQuestions, id: \.self) { i in
                        Button {
                            viewModel.counter = i
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(
                                        isShowingCorrection
                                        ? viewModel.selectedQuestions[i].value == nil
                                        ? .yellow
                                        : viewModel.selectedQuestions[i].value == viewModel.selectedQuestions[i].answer
                                        ? .green
                                        : .red
                                        : i == viewModel.counter
                                        ? .blue
                                        : viewModel.answeredIndexes.contains(i)
                                        ? .yellow
                                        : .gray
                                    )
                                    .frame(width: 40, height: 40)
                                Text("\(i + 1)")
                                    .foregroundColor(.white)
                                    .bold()
                                
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: viewModel.counter) { newIndex in
                reader.scrollTo(newIndex)
            }
        }
    }
}

struct AnswersSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AnswersSummaryView(viewModel: ViewModel("questions", "json"), isShowingCorrection: .constant(false))
    }
}
