//
//  RootView.swift
//  Planti
//
//  Created by Dominik Wieners on 06.12.20.
//

import SwiftUI

struct RootView: View {
    
    
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack{
                        Image(systemName: "leaf.fill")
                        Text("Suche")
                    }
                }
            DashboardView()
                .tabItem {
                    VStack{
                        Image(systemName: "applescript.fill")
                        Text("Übersicht")
                    }
                }
        }.accentColor(.green)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environment(\.colorScheme, .dark)
    }
}
