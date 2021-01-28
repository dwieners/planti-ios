//
//  PlantiApp.swift
//  Planti
//
//  Created by Dominik Wieners on 26.10.20.
//

import SwiftUI
import UIKit

@main
struct PlantiApp: App {
    // Percistence
    let persistenceController = PersistenceController.shared
    
    // View Models
    let authViewModel = AuthViewModel()
    let plantOverviewViewModel = PlantOverviewViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(plantOverviewViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
         
        }
    }
}
