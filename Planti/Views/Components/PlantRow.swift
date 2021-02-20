//
//  PlantRow.swift
//  Planti
//
//  Created by Dominik Wieners on 06.12.20.
//

import SwiftUI
import Kingfisher

struct PlantRow: View {
    
    var plant: PlantItem
    
    var body: some View {
        HStack{
            KFImage(URL(string: plant.image_url)!)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .mask(Rectangle()
                .cornerRadius(16))
            VStack(alignment: .leading){
                Text(plant.title).font(.headline).foregroundColor(.primary)
                Text(plant.scientific_name).font(.body).foregroundColor(.secondary)
            }
        }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        
        PlantRow(plant: PlantItem(id: 1, key: "bellis_perennis", title: "Gänseblümchen", scientific_name: "Bellis Perennis", image_url: "http://64.227.119.182:5000/api/plants/images/bellis_perennis")).previewAsComponent()
    }
}

