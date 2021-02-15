//
//  DashboardView.swift
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
                        DashboardItem(
                            title: "Pflanzenübersicht",
                            image: Image("sprout")
                        )
                        .padding([.horizontal, .top])
                    })
                LazyVStack{
                    HStack {
                        NavigationLink(
                            destination: RankingView()
                                .environmentObject(RankingViewModel()
                            ),
                            label: {
                                DashboardItem(
                                    title: "Rangliste",
                                    image: Image("quality"),
                                    small: true)
                            }
                        )
                        NavigationLink(
                            destination: MissionView(),
                            label: {
                                DashboardItem(
                                    title: "Missionen",
                                    image: Image("mission"),
                                    small: true)
                            }
                        )
                    }
                }
                .padding(.horizontal)
                NavigationLink(
                    destination: TestView(),
                    label: {
                        DashboardItem(
                            title: "Meine Tests",
                            image:  Image("cauldron")
                        )
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

