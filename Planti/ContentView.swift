//
//  ContentView.swift
//  Planti
//
//  Created by Dominik Wieners on 26.10.20.
//

import SwiftUI
import CoreData
import SwiftKeychainWrapper

enum Sheet: Identifiable {
    var id: Int {
        self.hashValue
    }
    case settings
    case camera
    case picker
    case avatar
    case selection
    case speech
    case register
    case login
}


struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    
    
    
    // # Actions
    private func getToken() {
        auth.token = KeychainWrapper.standard.string(forKey: "token")
    }
    
    
    var body: some View {
        ZStack{
            if auth.token != nil {
                RootView()
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }else{
                AuthView()
                    .zIndex(2.0)
            }
        }.onAppear(perform: getToken)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlantiNetViewModel())
            .environmentObject(AuthViewModel())
            .environmentObject(PlantOverviewViewModel())
    }
}
