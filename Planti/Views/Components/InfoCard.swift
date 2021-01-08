//
//  InfoCard.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct InfoCard: View {

    var image: Image
    var text: String
    
    var body: some View {
        LazyVStack {
            HStack {
                image.resizable().scaledToFit().frame(height: 50).padding(.trailing)
                Text(text).font(.body)
            }
        }
        .padding()
        .foregroundColor(.label)
        .background(Color.tertiarySystemBackground)
        .cornerRadius(10)
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(image: Image(systemName: "stethoscope"), text: "Gerne untersuchen wir deine Entdeckte Pflanze. Mache hierzu einfach ein Foto oder Verwende eines aus deiner Gallerie.")
            .previewAsComponent()
    }
}
