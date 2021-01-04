//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI


struct PlantRecoard: Identifiable {
    var id = UUID()
    var title: String
    var scientificName: String
    var keyVisual: String
}


struct HomeView: View {
    
    @State private var activeSheet: Sheet?
    
    
    let data = [
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower"),
        PlantRecoard(title: "Gänseblümchen", scientificName: "Bellis perennis", keyVisual: "flower")
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
                        ForEach(data, id: \.id) { item in
                            LazyVStack{
                                Image(item.keyVisual)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(8)
                                LazyVStack{
                                    Text(item.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer().frame(height: 4)
                                    Text(item.scientificName)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(8)
                            }.padding(.bottom, 8)
                        }
                        Spacer().frame(height: 50)
                    }
                    .padding()
                    .zIndex(0)
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                       activeSheet = .selection
                    }, label: {
                        LazyVStack{
                            HStack{
                                Image(systemName: "camera.viewfinder")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("Pflanze identifizieren")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }.frame(height: 50)
                    })
                    .background(Color.green)
                    .cornerRadius(25)
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 8)
                .zIndex(1)
                .ignoresSafeArea(.keyboard, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
            }
            .navigationBarTitle("Suche", displayMode: .inline)
            .add(self.searchBar)
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = .avatar
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.green)
                    })
          
                
            )
            .fullScreenCover(item: $activeSheet){ item in
                if item == .selection {
                    PredictionDashboardView(activeSheet: $activeSheet)
                }
                
                if item == .avatar {
                    AvatarView(activeSheet: $activeSheet)
                }
            }
        }

    }
    
    
}

struct PlantSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeView().environment(\.colorScheme, .light)
            HomeView() .environment(\.colorScheme, .dark)
        }
    }
}
