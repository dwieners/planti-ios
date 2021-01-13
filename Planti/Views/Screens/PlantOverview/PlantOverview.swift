//
//  PlantOverview.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct PlantOverview: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @ObservedObject var overview: PlantOverviewViewModel = PlantOverviewViewModel()
    
    
//    ForEach(dummyData, id: \.id) { item in
//        PlantRow(plant: item)
//    }
    
    // dummyData.filter{
    //    searchBar.text.isEmpty ||
    //    $0.name.localizedStandardContains(searchBar.text)
    
    var body: some View {
        List(
            overview.plants.filter{searchBar.text.isEmpty || $0.title.localizedStandardContains(searchBar.text)}
        ){ plant in
            NavigationLink(
                destination: PlantView(key: plant.key),
                label: {
                    PlantRow(plant: plant)
                })
           
            
        }
         .navigationBarTitle("Pflanzenübersicht")
        .add(self.searchBar)
        .onAppear(perform: {
            overview.loadOverview()
        })
            
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
