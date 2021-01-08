//
//  InfoRow.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

struct InfoRow: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(title).font(.headline).foregroundColor(.primary).padding(.bottom, 2)
                    Text(description).font(.body).foregroundColor(.secondary)
                }
                Spacer()
                //Image(systemName: "chevron.right").foregroundColor(.secondary)
            }
        }.padding(.vertical)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Meine Entdeckungen", description: "Siehe hier, welche Pflanzen du zuletzt entdeckt hast.")
            .previewLayout(.sizeThatFits)
    }
}
