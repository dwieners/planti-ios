//
//  MissionDetailView.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import SwiftUI

struct MissionDetailView: View {
    
    @ObservedObject var missionDetailViewModel = MissionDetailViewModel()
    
    var navTitle: String
    var missionId: Int
    
    var missionStartButton: some View {
        Button(action: {
            missionDetailViewModel.activateMissionStatus(missionId: missionId)
        }, label: {
            Text("Mission starten")
        })
        .accentColor(.green)
    }
    
    var body: some View {
        VStack {
            if let missionStatus = missionDetailViewModel.missionInfoStatus{
                List{
                    Section(header: Text("Beschreibung")) {
                        Text(missionStatus.mission.description)
                            .padding(.vertical)
                    }
                    Section(header: Text("Pflanzen")) {
                        ForEach(missionStatus.mission_targets) { (item: MyMissionTargetStatus) in
                            MissionTargetCheckView(title: item.title, isChecked: item.is_completed)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
               
                .navigationBarItems(trailing: missionStatus.mission.is_active ? AnyView(EmptyView()) : AnyView(missionStartButton))
                .alert(item: $missionDetailViewModel.missionDetailAlert, content: { (item) -> Alert in
                    switch item{
                    case .missionIsActive:
                        return  Alert(title: Text("Die Mission ist nun aktiv!"),
                                      message: Text("Die Macht sei mit dir!"),
                                      dismissButton: .default(Text("Alles klar!")))
                    }
                })
            } else {
                PlantiIndicatorView()
            }
            
        }
        .navigationBarTitle(navTitle)
        .onAppear(perform: {
            missionDetailViewModel.loadMissionStatus(missionId: missionId)
        })
        
    }
}

//struct MissionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MissionDetailView()
//        }
//
//    }
//}
