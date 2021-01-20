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
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var auth: AuthViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PlantRecord.timestamp, ascending: true)],
        animation: .default)

    private var items: FetchedResults<PlantRecord>

    var body: some View {
        ZStack{
            if auth.token != nil {
                RootView()
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                }else{
                    AuthView()
                        .zIndex(2.0)
            }
        }.onAppear(perform: {
            auth.token =  KeychainWrapper.standard.string(forKey: "token")
        })
    }

    private func addItem() {
        withAnimation {
            let newItem = PlantRecord(context: viewContext)
            newItem.timestamp = Date()
            

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
