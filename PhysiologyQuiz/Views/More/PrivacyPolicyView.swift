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
                Text("_\"Quiz fisiologia\"_ utilizza servizi di terze parti che raccolgono dati personali.")
                Text("È possibile che alcuni dati come indirizzi email o username vengano raccolti durante le richieste di supporto, questi verranno cancellati al termine del servizio di supporto e comunque non oltre un (1) anno.")

                Text("Dati raccolti da servizi di terze parti")
                    .font(.system(.headline))
                Text("Utilizziamo AdMob di Google per mostrare annunci pubblicitari nella versione \"gratuita\" dell'app. AdMob raccoglie dati e utilizza un identificatore univoco sul tuo dispositivo per mostrare annunci pertinenti per te. In conformità con il GDPR (Regolamento generale sulla protezione dei dati), gli utenti nell'EA (European Area Economica vedrà un messaggio che chiede il loro consenso. In conformità con il CPA (California Consumer Privacy Act), disabilitiamo la raccolta dei dati per utenti in California, Stati Uniti. Questi utenti vedranno solo annunci generici. Puoi vedere come Google utilizza i dati per mostrare annunci pertinenti qui.")
                Text(try! AttributedString(markdown: "Puoi modificare i consensi al trattamento dei dati da parte di AdMob tramite le impostazioni dell'app _(Schermata principale > Impostazioni)_"))
                Text(try! AttributedString(markdown: "Puoi vedere come Google utilizza i tuoi dati per mostrare annunci personalizzati [qui](https://policies.google.com/technologies/ads)."))

                Text("Domande relative a questa Privacy Policy e richieste di cancellazione dati")
                    .font(.system(.headline))
                    .padding(.top)
                Text(try! AttributedString(markdown: "Puoi richiedere ulteriori informazioni relative al trattamento dei dati personali da [qui](\(emailURL(subject: "Privacy Policy")))."))

                Text("Aggiornamento della Privacy Policy")
                    .font(.system(.headline))
                    .padding(.top)
                Text("Qualsiasi aggiornamento alla Privacy Policy verrà notificato nella schermata principale dell'applicazione.")
                Text("Ultimo aggiornamento: 5 Ottobre 2023")
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
