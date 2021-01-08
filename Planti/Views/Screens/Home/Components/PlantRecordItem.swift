//
//  PlantRecordItem.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct PlantRecordItem: View {
    
    var item: PlantRecoard
    
    var body: some View {
        LazyVStack{
            Image(item.keyVisual)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            LazyVStack{
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 4)
                Text(item.scientificName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding([.horizontal, .top], 8)
        }.padding(.bottom, 16)

    }
}

struct PlantRecordItem_Previews: PreviewProvider {
    static var previews: some View {
        PlantRecordItem(item: PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower") ).previewAsComponent()
    }
}
