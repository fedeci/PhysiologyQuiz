//
//  ActivityView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 14/07/22.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    var itemsToShare: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
