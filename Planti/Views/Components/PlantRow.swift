//
//  PlantRow.swift
//  Planti
//
//  Created by Dominik Wieners on 06.12.20.
//

import SwiftUI




struct PlantRow: View {
    
    var plant: PlantItem
    
    @State private  var image: UIImage = UIImage()
    @ObservedObject private var imageLoader: ImageLoader
    
    init(plant: PlantItem) {
        self.plant = plant
        self.imageLoader = ImageLoader(urlString: plant.image)
    }
    
    
    var body: some View {
        HStack{
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .mask(Rectangle()
                .cornerRadius(16))
                .onReceive(imageLoader.didChange){ data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
            VStack(alignment: .leading){
                Text(plant.title).font(.headline).foregroundColor(.primary)
                Text(plant.scientific_name).font(.body).foregroundColor(.secondary)
            }
        }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        
        PlantRow(plant: PlantItem(id: 1, key: "bellis_perennis", image: "http://192.168.0.80:5000/api/plants/images/bellis_perennis.png", title: "Gänseblümchen", scientific_name: "Bellis Perennis"))
    }
}

