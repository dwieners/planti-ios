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
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        DashboardViewItem(title: "Pflanzenübersicht", image: Image(systemName: "tray.2.fill"))
                            .padding([.horizontal, .top])
                    })
                LazyVStack{
                    HStack {
                        DashboardViewItem(title: "Rangliste", image: Image(systemName: "rosette"), small: true)
                        DashboardViewItem(title: "Missionen", image: Image(systemName: "crown"), small: true)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Übersicht")
            .navigationBarItems(trailing: Button(action: {
                activeSheet = .settings
            }, label: {
                Text("Einstellungen").foregroundColor(.green)
            }))
            .sheet(item: $activeSheet){ item in
                if item == .settings {
                    Text("Hallo")
                }
            }
            
            
        }
        
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            DashboardView().environment(\.colorScheme, .light)
            DashboardView().environment(\.colorScheme, .dark)
        }
    }
}
