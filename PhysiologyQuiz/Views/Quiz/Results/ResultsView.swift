//
//  ResultsView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct ResultsView: View {
    @Binding var isShowingSheet: Bool
    @ObservedObject var viewModel: ViewModel
    
    var correctPoints: Double {
        viewModel.settings.correctAnswer * Double(viewModel.correctAnswers.count)
    }
    
    var wrongPoints: Double {
        viewModel.settings.wrongAnswer * Double(viewModel.wrongAnswers.count)
    }
    
    var nonGivenPoints: Double {
        viewModel.settings.nonGivenAnswer * Double(viewModel.nonGivenAnswers.count)
    }

    var points: Double {
        correctPoints + wrongPoints + nonGivenPoints
    }

    var totalPoints: Double {
        let allCorrectPoints = viewModel.settings.correctAnswer * Double(viewModel.settings.numberOfQuestions)
        let allWrongPoints = viewModel.settings.wrongAnswer * Double(viewModel.settings.numberOfQuestions)
        let allNonGivenPoints = viewModel.settings.nonGivenAnswer * Double(viewModel.settings.numberOfQuestions)
        return [allCorrectPoints, allWrongPoints, allNonGivenPoints].max()!
    }

    var rightOnTotal: Double {
        Double(viewModel.correctAnswers.count) / Double(viewModel.settings.numberOfQuestions)
    }

    var nonGivenOnTotal: Double {
        Double(viewModel.nonGivenAnswers.count) / Double(viewModel.settings.numberOfQuestions)
    }

    var wrongOnTotal: Double {
        Double(viewModel.wrongAnswers.count) / Double(viewModel.settings.numberOfQuestions)
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 160)
                        .cornerRadius(15)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text("\(points, specifier: "%.2f") / \(totalPoints, specifier: "%.2f")")
                                    .foregroundColor(Color(uiColor: .label))
                                    .font(.system(.title2, design: .rounded).weight(.heavy))
                                Text("punti")
                                    .foregroundColor(Color(uiColor: .secondaryLabel))
                                    .font(.system(.title3, design: .rounded).weight(.medium))
                            }
                            Spacer()
                            SmallStatView(label: Text("\(rightOnTotal * 100, specifier: "%.2f") %"), color: .green)
                            SmallStatView(label: Text("\(wrongOnTotal * 100, specifier: "%.2f") %"), color: .red)
                            SmallStatView(label: Text("\(nonGivenOnTotal * 100, specifier: "%.2f") %"), color: .yellow)
                        }
                        Spacer(minLength: 30)
                        Chart(data: (rightOnTotal, wrongOnTotal, nonGivenOnTotal))
                            .aspectRatio(1.3, contentMode: .fit)
                    }
                        .padding()
                }
                    .frame(height: 160)
                ResultRowView(configuration: .init(title: "Risposte corrette", titleColor: .green, systemImage: "checkmark.circle.fill", answers: viewModel.correctAnswers, points: correctPoints))
                ResultRowView(configuration: .init(title: "Risposte errate", titleColor: .red, systemImage: "multiply.circle.fill", answers: viewModel.wrongAnswers, points: wrongPoints))
                ResultRowView(configuration: .init(title: "Risposte non date", titleColor: .yellow, systemImage: "questionmark.circle.fill", answers: viewModel.nonGivenAnswers, points: nonGivenPoints))
                Spacer()
            }
            .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
            .padding()
            .background(Color(uiColor: UIColor.systemBackground))
            .navigationTitle("Punteggi")
            .toolbar {
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Fine")
                        .bold()
                }

            }
        }
    }
}

struct SmallStatView: View {
    var label: Text
    var color: Color

    var body: some View {
        HStack(spacing: 6) {
            Rectangle()
                .fill(color)
                .frame(width: 15, height: 15)
                .cornerRadius(5)
            label
                .foregroundColor(Color(uiColor: .secondaryLabel))
                .font(.system(.body, design: .rounded).weight(.medium))
        }
    }
}

struct ResultRowView: View {
    var configuration: Configuration

    struct Configuration {
        var title: String
        var titleColor: Color
        var systemImage: String
        var answers: Questions
        var points: Double
    }

    var body: some View {
        NavigationLink {
            ResultsListView(title: configuration.title, questions: configuration.answers)
        } label: {
            ZStack {
                Rectangle()
                    .cornerRadius(15)
                    .frame(height: 100)
                HStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image(systemName: configuration.systemImage)
                            Text(configuration.title)
                                .bold()
                        }
                        .foregroundColor(configuration.titleColor)
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 14) {
                            Text("\(configuration.answers.count)")
                                .foregroundColor(Color(uiColor: .label))
                                .font(.system(.title, design: .rounded).weight(.heavy))
                            Text("\(configuration.points >= 0 ? "+" : "-")\(abs(configuration.points), specifier: "%.2f") punti")
                                .foregroundColor(Color(uiColor: .tertiaryLabel))
                                .font(.system(.title2, design: .rounded).weight(.bold))
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                    .padding()
            }
        }
        .frame(height: 100)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(isShowingSheet: .constant(true), viewModel: ViewModel("questions", "json"))
    }
}
