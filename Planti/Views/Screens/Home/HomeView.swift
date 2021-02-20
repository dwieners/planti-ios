//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI
import CoreData
import WaterfallGrid


enum HomeAlerts: Identifiable {
    var id: Int {
        self.hashValue
    }
    case deleteDatabase
    case notDeleteDatabase
}


struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PlantRecord.timestamp, ascending: false)],
        animation: .default)
    
    private var items: FetchedResults<PlantRecord>
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @State private var homeAlerts: HomeAlerts?
    
    @State private var activeSheet: Sheet?
    
    @State private var selectedKey: String = ""
    
    @State private var isActiveRecordItem: Bool = false
    
    /**
         # Actions
     */
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
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
    
    private func showOnboarding() -> Bool {
        return UserDefaults.standard.object(forKey: "onboarding_done") == nil
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                if items.count > 0 {
                    ScrollView{
                        WaterfallGrid(
                            items.filter{
                                searchBar.text.isEmpty ||
                                    $0.title!.localizedStandardContains(searchBar.text)
                            }, id: \.id) { item in
                            
                            PlantRecordItem(item: item)
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        let selectedItem = items.lastIndex(of: item)
                                        if let selected = selectedItem {
                                            self.deleteItems(offsets: [selected])
                                        }
                                    }, label: {
                                        Label(item.title!, systemImage: "trash")
                                            .accentColor(Color.red)
                                    })
                                }))
                                .onTapGesture() {
                                    self.selectedKey = item.key!
                                    self.isActiveRecordItem.toggle()
                                }
                        }
                        .gridStyle(spacing: 16)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                        Spacer().frame(height: 50)
                    }.zIndex(1.0)
                }else{
                      HomePlaceholderView()
                }
                
                NavigationLink(destination: PlantView(key: selectedKey)
                                .environmentObject(PlantViewModel()), isActive: $isActiveRecordItem ){
                    Spacer().fixedSize()
                }
                
                VStack {
                    Spacer()
                    FloatingButton(action: {
                        activeSheet = .selection
                    }, image: Image(systemName: "camera.viewfinder"), label: "Pflanze bestimmen")
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 16)
                .ignoresSafeArea(.keyboard, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                .zIndex(2.0)
                
            }
            .navigationBarTitle("Suche")
            .add(self.searchBar)
            .onAppear(perform: {
                if showOnboarding() {
                    activeSheet = .onboarding
                }
            })
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = .avatar
                    }, label: {
                        Label("Dein Avatar", systemImage: "person.crop.circle.fill")
                    }),
                trailing:
                    Button(action: {
                        if (items.count > 0) {
                            self.homeAlerts = .deleteDatabase
                        } else {
                            self.homeAlerts = .notDeleteDatabase
                        }
                    }, label: {
                        if (items.count > 0) {
                            Image(systemName: "cylinder.split.1x2.fill")
                                .imageScale(.large)
                                .frame(width: 44, height: 44, alignment: .trailing)
                        } else {
                            Image(systemName: "cylinder.split.1x2")
                                .imageScale(.large)
                                .frame(width: 44, height: 44, alignment: .trailing)
                        }
                    })
            ).alert(item: $homeAlerts, content: { item -> Alert in
                switch(item){
                case .deleteDatabase:
                    return Alert(title: Text("Möchtest du deine Beobachtungen löschen?"),
                                 primaryButton: .default (Text("Ja")) {
                                    let array:[Int] = Array(0...(items.count-1))
                                    deleteItems(offsets: IndexSet(array))
                                 },
                                 secondaryButton: .cancel()
                    )
                case .notDeleteDatabase:
                    return Alert(title: Text("Du hast noch keine Beobachtungen gemacht. 👀"), message: Text("Finde Pflanzen, um deine Historie zu füllen"), dismissButton: .default(Text("Alles klar!")))
                    
                }
            })
            
            .fullScreenCover(item: $activeSheet){ item in
                if item == .selection {
                    SelectionDashboardView(predictionSheet: $activeSheet)
                        .environmentObject(SelectionViewModel())
                        .environmentObject(PlantiNetViewModel())
                        .environmentObject(LocationManager())
                }
                
                if item == .avatar {
                    AvatarView(activeSheet: $activeSheet)
                }
                
                if item == .onboarding {
                    HomeOnboardingView(activeSheet: $activeSheet)
                }
            }
        }.accentColor(.green)
    }
    
    
    
    
}

struct PlantSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
