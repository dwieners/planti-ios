//
//  PlantRecordItem.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI
import CoreData

struct PlantRecordItem: View {
    
    var item: PlantRecord
    
    var body: some View {
        LazyVStack{
            Image(uiImage: UIImage(data: item.image!)!)
                .resizable()
                .scaledToFit()
                .mask(RoundedCorner(radius: 10, corners: .allCorners))
            LazyVStack{
                Text(item.title!)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.scientific_name!)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding( 8)
        }
        .background(Color.systemBackground)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

//struct PlantRecordItem_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantRecordItem(item: PlantRecord() ).previewAsComponent()
//    }
//}
