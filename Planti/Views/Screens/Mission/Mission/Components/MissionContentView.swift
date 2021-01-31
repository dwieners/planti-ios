//
//  MissionContentView.swift
//  Planti
//
//  Created by Dominik Wieners on 30.01.21.
//

import SwiftUI


var myMissionsExample:MyMissions = MyMissions(
    active:[
        MyActiveMission(id: 2, image_url: nil, title: "Heilkreuter", description: "Hier eine Beschreibung", complete_targets: 0, total_targets: 10)
    ] ,
    inactive: [
        MyInactiveMission(id: 1, image_url: nil, title: "Blüten", description: "Hier eine Beschreibung", complete_targets: 0, total_targets: 10)
    ])

struct MissionContentView: View {
    
    var myMissions: MyMissions
    
    func noActiveMissions() -> Bool {
        return myMissions.active.count == 0
    }
    
    func noInactiveMissions() -> Bool {
        return myMissions.inactive.count == 0
    }
    
    var body: some View {
        List{
            Section(header: Text("Aktiv")) {
                if noActiveMissions() {
                    MissionEmptyView(type: .NO_ACTIVE_MISSIONS, description: "Es sind noch keine Missionen aktiv.")
                } else {
                    ForEach(myMissions.active) { (item:MyActiveMission) in
                        
                        NavigationLink(
                            destination: MissionDetailView(navTitle: item.title, missionId: item.id),
                            label: {
                                MissionActiveItemView(item: item)
                            })
                        
                       
                    }
                }
            }
            
            Section(header: Text("Inaktiv")) {
                if noInactiveMissions() {
                    MissionEmptyView(type: .NO_INACTIVE_MISSIONS, description: "Es sind alle Missionen aktiv.")
                }else{
                    
                    MissionInactiveItemView(inactiveMissions: myMissions.inactive)
                }
            }
            
        }.listStyle(GroupedListStyle())
    }
}

struct MissionContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MissionContentView(myMissions: myMissionsExample)
                .navigationBarTitle("Missionen")
        }
    }
}
