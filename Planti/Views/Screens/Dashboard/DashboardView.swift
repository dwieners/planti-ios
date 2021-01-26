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
                            destination: RankingView().environmentObject(RankingViewModel()),
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




//VStack(alignment: .leading)
//        {
//            HStack(alignment: .center)
//            {
//                Image(systemName: "flame.fill")
//                    .font(.system(size: 16, weight: .regular))
//                    .padding(14)
//                    .foregroundColor(.white)
//                    .background(
//                        Circle().fill(Color.green)
//                    )
//                Spacer()
//                
//                Text("2")
//                    .font(.title)
//                    .bold()
//                
//            }
//            Text("Hallo")
//                .bold()
//                .multilineTextAlignment(.leading)
//                .foregroundColor(Color(.secondaryLabel))
//        }
//        .padding()
//        .background(Color(.secondarySystemGroupedBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 12))
