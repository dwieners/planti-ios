//
//  PlantRow.swift
//  Planti
//
//  Created by Dominik Wieners on 06.12.20.
//

import SwiftUI


struct PlantModel:Identifiable, Hashable{
    var id = UUID()
    var image: UIImage
    var name: String
    var type: String
}

struct PlantRow: View {
    
    var plant: PlantModel
    
    var body: some View {
        HStack{
            Image(uiImage: plant.image).resizable().frame(width: 64, height: 64).mask(Rectangle().cornerRadius(16))
            VStack(alignment: .leading){
                Text(plant.name).font(.headline).foregroundColor(.primary)
                Text(plant.type).font(.body).foregroundColor(.secondary)
            }
        }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        
        PlantRow(plant: dummyData[0]).previewAsComponent()
    }
}


let dummyData = [
    PlantModel(image: UIImage(named: "roses")!, name: "Rose", type: "Bellis peneris"),
    PlantModel(image: UIImage(named: "flower")!, name: "Gänseblümchen", type: "Bellis peneris"),
]
