//
//  PlantDescriptionView.swift
//  Planti
//
//  Created by Dominik Wieners on 27.01.21.
//

import SwiftUI

struct PlantDescriptionView: View {
    
    var plantInfo: PlantInfo
    
    var body: some View {
        VStack {
            Spacer().frame(maxWidth: .infinity)
            HStack{
                VStack(alignment: .leading){
                    Text(plantInfo.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(plantInfo.scientific_name)
                        .font(.headline)
                }
                Spacer()
            }.padding()
            .background(BlurView(style: .prominent))
        }
    }
}

