//
//  HomeOnboardingView.swift
//  Planti
//
//  Created by Dominik Wieners on 18.02.21.
//

import SwiftUI

struct HomeOnboardingView: View {
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        TabView {
            OnboardingItemView(activeSheet: $activeSheet, image: Image("magic-wand"), title: "Werde Kräuterhexe oder Kräuterzauberer", description: "Messe dich mit Freunden bei der Beobachtung von Kräutern und entwickle deinen Avatar.", hasDismiss: false)
            OnboardingItemView(activeSheet: $activeSheet, image: Image("mission"), title: "Erfülle spannende Missionen", description: "Aktiviere im Missionsmenü deine individuellen Kategorien und starte mit der Pflanzenjagt.", hasDismiss: false)
            OnboardingItemView(activeSheet: $activeSheet, image: Image("green-leaf"), title: "Wir wünschen dir viel Spaß beim Beobachten und Entdecken!", hasDismiss: true)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct HomeOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        HomeOnboardingView(activeSheet: .constant(nil))
    }
}
