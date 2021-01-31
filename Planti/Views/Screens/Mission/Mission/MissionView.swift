//
//  MissionView.swift
//  Planti
//
//  Created by Dominik Wieners on 04.01.21.
//

import SwiftUI

struct Mission : Identifiable {
    
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}

var stats_Data = [
    
    Mission(id: 0, title: "Tee", currentData: 6.8, goal: 15, color: .blue),
    
    Mission(id: 1, title: "Heilkräuter", currentData: 3.5, goal: 5, color: .green),
]

struct MissionView: View {
    
    @ObservedObject var missionViewModel = MissionsViewModel()
    
    var body: some View {
        VStack {
            if let myMission = missionViewModel.myMissions{
                MissionContentView(myMissions: myMission)
                    .environmentObject(missionViewModel)
            }else{
                PlantiIndicatorView()
            }
        }.onAppear(perform: {
            missionViewModel.loadMyMission()
        })
        .accentColor(.green)
        .navigationBarTitle("Missionen")
    }
    
}

//struct MissionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MissionView()
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .previewAsScreen()
//    }
//}
