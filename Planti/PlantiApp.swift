//
//  PlantiApp.swift
//  Planti
//
//  Created by Dominik Wieners on 26.10.20.
//

import SwiftUI

@main
struct PlantiApp: App {
    let persistenceController = PersistenceController.shared
    let auth = AuthViewModel()

    let plantOverview = PlantOverviewViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
                .environmentObject(plantOverview)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
         
        }
    }
}
