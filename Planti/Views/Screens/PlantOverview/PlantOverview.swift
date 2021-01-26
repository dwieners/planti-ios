//
//  PlantOverview.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct PlantOverview: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @EnvironmentObject var overview: PlantOverviewViewModel
    
    var body: some View {
        List(
            overview.plants.filter{searchBar.text.isEmpty || $0.title.localizedStandardContains(searchBar.text)}
        ){ plant in
            NavigationLink(
                destination:
                    PlantView(key: plant.key)
                    .environmentObject(PlantViewModel()),
                label: {
                    PlantRow(plant: plant)
                })
        }
         .navigationBarTitle("Pflanzenübersicht")
        .add(self.searchBar)
        .onAppear(perform: {
            if overview.plants.isEmpty {
                overview.loadOverview()
            }
        })
    }
}

struct PlantOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PlantOverview()
                .environmentObject(PlantOverviewViewModel())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewAsScreen()
    }
}
