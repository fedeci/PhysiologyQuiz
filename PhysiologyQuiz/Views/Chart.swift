//
//  Chart.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 13/07/22.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct Chart: View {
    var data: (CGFloat, CGFloat, CGFloat)

    var body: some View {
        GeometryReader { view in
            let minBarHeight = view.size.height / 12
            let effective100Height = view.size.height * 10 / 12
            let barWidth = view.size.width / 3.4
            ZStack {
                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0) {
                        Rectangle()
                            .fill(.green)
                            .frame(width: barWidth, height: minBarHeight + effective100Height * data.0)
                            .cornerRadius(3)
                        Spacer()
                        Rectangle()
                            .fill(.red)
                            .frame(width: barWidth, height: minBarHeight + effective100Height * data.1)
                            .cornerRadius(3)
                        Spacer()
                        Rectangle()
                            .fill(.yellow)
                            .frame(width: barWidth, height: minBarHeight + effective100Height * data.2)
                            .cornerRadius(3)
                    }
                }
                VStack {
                    Line()
                        .stroke(style: .init(lineWidth: 0.5, dash: [4]))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .frame(height: 0.5)
                    Spacer()
                    Line()
                        .stroke(style: .init(lineWidth: 0.5, dash: [4]))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .frame(height: 0.5)
                    Spacer()
                    Line()
                        .stroke(style: .init(lineWidth: 0.5, dash: [4]))
                        .foregroundColor(Color(uiColor: .systemGray))
                        .frame(height: 0.5)
                }
                .offset(y: 0.25)
                .frame(height: effective100Height + 0.5)
            }
        }
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart(data: (0, 0.5, 1))
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 200)
    }
}
