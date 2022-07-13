//
//  AllQuestionsView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct AllQuestionsView: View {
    @State private var searchText = ""
    @Binding var isShowingQuestions: Bool
    
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List(searchResults, id: \.self, rowContent: { question in
                NavigationLink {
                    QuestionDetailView(question: question)
                } label: {
                    HStack {
                        Text(question.question)
                            .bold()
                            .lineLimit(2)
                        Spacer(minLength: 25)
                        Image(systemName: question.answer ? "checkmark.circle.fill" : "multiply.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(question.answer ? .green : .red)
                    }
                    .frame(height: 60)
                }
            })
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(Text("Quesiti"))
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowingQuestions.toggle()
                    } label: {
                        Text("Fine")
                            .bold()
                    }

                }
            }
        }
    }
    
    var searchResults: Questions {
        if searchText.isEmpty {
            return viewModel.questions
        } else {
            return viewModel.questions.filter { question in
                if question.question.localizedCaseInsensitiveContains(searchText) {
                    return true
                }
                if let details = question.details, details.localizedCaseInsensitiveContains(searchText) {
                    return true
                }
                return false
            }
        }
    }
}

struct AllQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        AllQuestionsView(isShowingQuestions: .constant(true), viewModel: ViewModel("questions", "json"))
    }
}
