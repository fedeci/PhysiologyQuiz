//
//  CreditsView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 14/07/22.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Autore")
                    .font(.system(.headline))
                Text("L'applicazione è stata sviluppata da Federico Ciardi e resa [Open Source](https://github.com/fedeci/PhysiologyQuiz) sotto licenza MIT.")
                Text("Database quiz")
                    .font(.system(.headline))
                    .padding(.top)
                Text("Il [database dei quiz](https://github.com/fedeci/PhysiologyQuiz/blob/main/PhysiologyQuiz/Data/questions.json) è pubblico e modificabile da chiunque.")
                Text("Assets grafici")
                    .font(.system(.headline))
                    .padding(.top)
                Text("L'immagine sulla schermata principale è fornita da [undraw.co](https://undraw.co) sotto [licenza](https://undraw.co/license).")
                Text("I simboli dei social network sono forniti da [icons8.com](https://blog.icons8.com/articles/free-social-media-logos-for-sf-symbols/).")
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
            .navigationTitle("Crediti")
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
