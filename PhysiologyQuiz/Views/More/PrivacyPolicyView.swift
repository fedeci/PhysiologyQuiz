//
//  PrivacyPolicyView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 13/07/22.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Che dati sono raccolti?")
                    .font(.system(.headline))
                Text("_\"Quiz fisiologia\"_ non raccoglie né condivide alcuna informazione riservata durante l'utilizzo dell'applicazione.")
                Text("È possibile che alcuni dati come indirizzi email o username vengano raccolti durante le richieste di supporto, questi verranno cancellati al termine del servizio di supporto e comunque non oltre un (1) anno.")
                Text("Domande relative a questa Privacy Policy e richieste di cancellazione dati")
                    .font(.system(.headline))
                    .padding(.top)
                Text(try! AttributedString(markdown: "Puoi richiedere ulteriori informazioni relative al trattamento dei dati personali cliccando [qui](\(emailURL(subject: "Privacy Policy")))."))
                Text("Aggiornamento della Privacy Policy")
                    .font(.system(.headline))
                    .padding(.top)
                Text("Qualsiasi aggiornamento alla Privacy Policy verrà notificato nella schermata principale dell'applicazione.")
                Text("Ultimo aggiornamento: 14 Luglio 2022")
                    .italic()
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
