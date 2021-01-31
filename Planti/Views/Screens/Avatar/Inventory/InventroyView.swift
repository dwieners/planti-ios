//
//  InventoryView.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct InventoryView: View {
    
    
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    
    
    var score: Int
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    //    var data = [
    //        MyInventory(id: 1, name: "Hörner", description: "Beispieltext", score_to_unlock: 100, type: .HORNS_HAT, unlock: false)
    //    ]
    //
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(inventoryViewModel.invetoryItems) { item in
                    InventoryItemView(item: item)
                }
            }
            .padding()
            .navigationBarTitle(Text("Mein Inventar"))
            
        }.onAppear(perform: {
            inventoryViewModel.loadInventory()
        })
        
        
    }
}

//struct InventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            InventoryView()
//        }
//    }
//}
