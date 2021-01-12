//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI


struct PlantRecoard: Identifiable {
    var id = UUID()
    var key: String
    var title: String
    var scientificName: String
    var keyVisual: String
}


struct HomeView: View {
    
    @State private var activeSheet: Sheet?
    
    
    let data = [
        PlantRecoard(key: "bellis_perennis", title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(key: "allium_ursinum", title: "Sonnnenblume", scientificName: "Bellis perennis", keyVisual: "roses"),
        PlantRecoard( key: "helianthus_annuus" ,title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(key: "papaver_rhoeas", title: "Sonnnenblume", scientificName: "Bellis perennis", keyVisual: "flower")
    ]
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView{
            ZStack{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(
                            data.filter{
                                searchBar.text.isEmpty ||
                                    $0.title.localizedStandardContains(searchBar.text)
                            }, id: \.id) { item in
                            NavigationLink(
                                destination: PlantView(key: item.key),
                                label: {
                                    PlantRecordItem(item: item)
                                })
                        }
                        Spacer().frame(height: 50)
                    }
                    .padding()
                }
                
                VStack {
                    Spacer()
                    FloatingClassifyButton(image: Image(systemName: "camera.viewfinder"), label: "Pflanze bestimmen", activeSheet: $activeSheet)
                        .padding(.horizontal, 32)
                }
                .padding(.bottom, 16)
                .ignoresSafeArea(.keyboard, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
            }
            .navigationBarTitle("Suche")
            .add(self.searchBar)
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = .avatar
                    }, label: {
                        Image(systemName: "person.circle.fill").resizable()
                    })
                
                
            )
            .fullScreenCover(item: $activeSheet){ item in
                if item == .selection {
                    PredictionDashboardView(predictionSheet: $activeSheet)
                }
                
                if item == .avatar {
                    AvatarView(activeSheet: $activeSheet)
                }
            }
        }.accentColor(.green)
    }
    



}

struct PlantSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
