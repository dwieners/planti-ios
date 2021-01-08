//
//  PlantOverview.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct PlantOverview: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    
//    ForEach(dummyData, id: \.id) { item in
//        PlantRow(plant: item)
//    }
    
    var body: some View {
        List(
            dummyData.filter{
                searchBar.text.isEmpty ||
                $0.name.localizedStandardContains(searchBar.text)
            }
        ){ plant in
            PlantRow(plant: plant)
        }
         
        
            .navigationBarTitle("Pflanzenübersicht")
            .add(self.searchBar)
            
    }
}

struct PlantOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PlantOverview()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewAsScreen()
    }
}
