//
//  MissionTargetComplete.swift
//  Planti
//
//  Created by Dominik Wieners on 01.02.21.
//

import SwiftUI

struct MissionTargetCompleteView: View {
    
    var missionComplete: MyMissionTargetCompleteStatus?
    @Binding var sheet: MissionTargetStatusSheet?
    
    
    
    var cancelButton: some View {
        CancelButton {
            self.sheet = nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let missionComplete = missionComplete {
                    ScrollView {
                        Image("businessman").resizable().scaledToFit().frame(height: 200).padding()
                        LazyVStack(alignment: .leading) {
                            HStack {
                                Text(missionComplete.mission_title).font(.title).bold()
                            }
                            MissionTargetCheckView(title: missionComplete.target_title, isChecked: true)
                        }
                        .padding()
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(10)
                        .padding()
                        
                    }
                }else{
                    PlantiIndicatorView()
                }
            }
            .navigationBarTitle("Ziel erreicht")
            .navigationBarItems(leading: cancelButton)
            
        }.accentColor(.green)
      
    
    }
}

struct MissionTargetCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTargetCompleteView(
            missionComplete: MyMissionTargetCompleteStatus(
                                    mission_title: "Blüten",
                                    target_title: "Finde ein Gänseblümchen"),
            sheet: .constant(nil)
        )
    }
}
