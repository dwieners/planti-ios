//
//  ProfileView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI




struct DashboardView: View {
    
    @State private var activeSheet: Sheet?
    
    var body: some View {
        NavigationView {
            ScrollView{
                NavigationLink(
                    destination: PlantOverview(),
                    label: {
                        DashboardItem(title: "Pflanzenübersicht", image: Image(systemName: "tray.2.fill"))
                            .padding([.horizontal, .top])
                    })
                LazyVStack{
                    HStack {
                        NavigationLink(
                            destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                            label: {
                                DashboardItem(title: "Rangliste", image: Image(systemName: "rosette"), small: true)
                            }
                        )
                        NavigationLink(
                            destination: MissionView(),
                            label: {
                                DashboardItem(title: "Missionen", image: Image(systemName: "crown"), small: true)
                            }
                        )
                    }
                }
                .padding(.horizontal)
                NavigationLink(
                    destination: TestView(),
                    label: {
                        DashboardItem(title: "Meine Tests", image: Image(systemName: "flame.fill"))
                            .padding([.horizontal])
                           
                    })
            }
            .navigationBarTitle("Übersicht")
            .navigationBarItems(trailing: Button(action: {
                activeSheet = .settings
            }, label: {
                Text("Einstellungen")
            }))
            .sheet(item: $activeSheet){ item in
                if item == .settings {
                    SettingsView(activeSheet: $activeSheet)
                }
            }
            
            
        }.accentColor(.green)
        
    }
    

      
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().previewAsScreen()
    }
}
