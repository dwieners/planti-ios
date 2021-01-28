//
//  PlantTextContentView.swift
//  Planti
//
//  Created by Dominik Wieners on 27.01.21.
//

import SwiftUI

struct PlantTextContentView: View {
    
    var plantInfo: PlantInfo
    
    var body: some View {
        VStack(alignment: .leading){
            LazyVStack(alignment: .leading){
                Text("Taxonomie")
                    .font(.headline)
                    .padding(.bottom, 4)
                Text(plantInfo.taxonomy)
            }.padding(8)
            Divider()
            LazyVStack(alignment: .leading){
                Text("Beschreibung")
                    .font(.headline)
                    .padding(.bottom, 4)
                Text(plantInfo.description)
                    .font(.body)
                    .lineLimit(nil)
            }.padding(8)
            
        }.padding()
    }
}
