//
//  PlantDetailView.swift
//  Planti
//
//  Created by Dominik Wieners on 08.01.21.
//

import SwiftUI
import CoreLocation
import SwiftKeychainWrapper





struct PlantView: View {
    @EnvironmentObject private var plantViewModel: PlantViewModel
    
    @ObservedObject private var observationViewModel = ObservationViewModel()
    @ObservedObject private var missionTargetViewModel = MissionTargetViewModel()
    
    @State private var isLoading:Bool = false
    @State private var opacity:Double = 0
    
    var key:String
    var location: CLLocation?
    var selectedImage: UIImage?
    var predictionSheet: Binding<Sheet?>?
   
    
    var observationButton: some View {
        Button(action: {
            observationViewModel.plantViewAlert = .sendObservation
        }, label: {
            Image(systemName: "arrow.up.doc.fill")
                .imageScale(.large)
                .frame(width: 44, height: 44, alignment: .trailing)
        })
    }
    
    
    func missionTargetDismiss() {
        self.predictionSheet?.wrappedValue = nil
    }
    
    
    
    var body: some View{
        VStack{
            
            ZStack {
                if plantViewModel.isLoading {
                    PlantiIndicatorView()
                        .zIndex(2)
                } else {
                    if let plant = plantViewModel.plant {
                        PlantViewContent(plantInfo: plant, predictionSheet: predictionSheet, selectedImage: selectedImage)
                            .environmentObject(observationViewModel)
                            .environmentObject(missionTargetViewModel)
                            .opacity(opacity)
                            .onAppear(perform: {
                                withAnimation(.default) {
                                    self.opacity = 1
                                }
                            })
                            .zIndex(1)
                    }
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
        .edgesIgnoringSafeArea(.top)
        .alert(item: $observationViewModel.plantViewAlert, content: { item -> Alert in
            switch(item){
            case .sendObservation:
                return Alert(title: Text("Möchtest du uns deine Daten senden?"),
                             primaryButton: .default (Text("Ja")) {
                                guard let plant = plantViewModel.plant else { return }
                                
                                guard let uiImage = selectedImage else { return }
                                
                                guard let location = self.location else {return}
                                
                                observationViewModel.uploadObservation(
                                    uiImage: uiImage,
                                    key: plant.key,
                                    latitude: location.coordinate.latitude,
                                    longitude: location.coordinate.longitude
                                )
                             },
                             secondaryButton: .cancel()
                )
            case .hasSendObservation:
                return Alert(title: Text("Vielen Dankt!"),
                             message: Text("Die Hexenmeister bedanken sich. 🧙‍♂️"),
                             dismissButton: .default(Text("Alles klar!")))
                
            case .dailyPoints:
                return Alert(title: Text("Die Hexenmeister geben dir deinen Tagesbonus!"),
                             message: Text("Du erhälst 5 Punkite 🤗"),
                             dismissButton: .default(Text("Alles klar!")))
                
            case .unlockedMission:
                return Alert(title:Text("Eine neue Mission wurde Freigeschaltet"),
                             dismissButton: .default(Text("Alles klar!")))
            }
            
        })
        .navigationBarTitle(Text("Details"), displayMode: .inline)
        .sheet(item: $missionTargetViewModel.missionTargetStatusSheet, onDismiss: missionTargetDismiss, content: { _ in
               
               return AnyView(MissionTargetCompleteView(missionComplete: missionTargetViewModel.completedTarget, sheet: $missionTargetViewModel.missionTargetStatusSheet))
            
        })
        .navigationBarItems(
            trailing:
                self.predictionSheet != nil ?
                AnyView(self.observationButton):
                AnyView(EmptyView())
        )
        .onAppear(perform: {
            plantViewModel.loadInfo(key: key)
        })
    }
    
}



struct PlantViewContent : View {
    
    @EnvironmentObject private var plantViewModel: PlantViewModel
    @EnvironmentObject private var observationViewModel: ObservationViewModel
    @EnvironmentObject private var missionTargetViewModel: MissionTargetViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var opacity:Double = 0.0
     
    var plantInfo: PlantInfo
    var predictionSheet: Binding<Sheet?>?
    var selectedImage: UIImage?
    

    // Actions
    
    private func addItem() {
        // load image from url and save to here
        guard let plant = plantViewModel.plant else {
            return
        }
        //        if let url = URL(string: plant.image_url) {
        //            let data = try? Data(contentsOf: url)
        //            uiImage = UIImage(data: data!)!
        //        }
        guard let uiImage = selectedImage else { return }
        
        let newItem = PlantRecord(context: viewContext)
        newItem.timestamp = Date()
        newItem.key = plant.key
        newItem.title = plant.title
        newItem.scientific_name = plant.scientific_name
        newItem.image = uiImage.jpegData(compressionQuality: 0.5)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    
    func checkMissions() {
        guard let plant = plantViewModel.plant else {
            return
        }
        missionTargetViewModel.checkMissions(key: plant.key)
       
    }
    
    
    
    func checkForDailyScore() {
        let current_timestamp = NSDate().timeIntervalSince1970
        let last_bonus_timestamp = KeychainWrapper.standard.string(forKey: "last_daily_bonus")
        if let last_bonus_timestamp = last_bonus_timestamp {
            let last_timestamp = TimeInterval(last_bonus_timestamp)!
            let diffInSeconds = current_timestamp - last_timestamp //total time difference in seconds
            // let hours = diffInSeconds/60/60 //hours=diff in seconds / 60 sec per min / 60 min per hour
            let min = diffInSeconds/60 // min
            let timeToWait = 2.0 - min
            debugPrint("⏰ [TIME TO WAIT] \(String(format: "%3.0f", timeToWait < 0 ? 0 : timeToWait)) min")
            if min < 2 {
                debugPrint("😢 [NO DAILY BONUS] Sorry")
            } else {
                debugPrint("💰 [DAILY BONUS] 5 Points")
                observationViewModel.getDailyBonus()
                KeychainWrapper.standard.set(String(current_timestamp), forKey: "last_daily_bonus")
            }
        }else{
            KeychainWrapper.standard.set(String(current_timestamp), forKey: "last_daily_bonus")
            observationViewModel.getDailyBonus()
            print(current_timestamp)
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ZStack{
                            KeyVisualView(imageUrl: plantInfo.image_url)
                                .frame(height: 400)
                                .frame(maxWidth: .infinity)
                            PlantDescriptionView(plantInfo: plantInfo)
                        }
                        
                    }
                    PlantTextContentView(plantInfo: plantInfo)
                    if predictionSheet != nil {
                        Spacer().frame(height: 72)
                    }
                }.zIndex(0)
                
                if let predictionSheet = predictionSheet {
                    VStack {
                        Spacer()
                        FloatingButton(
                            action: {
                              addItem()
                              checkMissions()
                            },
                            image: Image(systemName: "checkmark.circle.fill"),
                            label: "Bestätigen"
                        )
                        
                    }
                    .padding()
                    .onReceive(missionTargetViewModel.$missionsUpToDate, perform: { upToDate in
                        if upToDate {
                            predictionSheet.wrappedValue = nil
                        }
                    })
                    .onAppear(perform: {
                        self.checkForDailyScore()
                    })
                    .zIndex(1)
                }
                
            }
            .opacity(opacity)
            .onAppear(perform: {
                withAnimation(.default) {
                    self.opacity = 1
                }
            })
            
        }
        
        .ignoresSafeArea(.keyboard, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        
        
    }
    
}


struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            PlantView(key: "bellis_perennis", predictionSheet: .constant(.selection))
                .environmentObject(PlantViewModel())
                .environmentObject(ObservationViewModel())
        }
        .accentColor(.green)
    }
}
