//
//  MissionInactiveItemView.swift
//  Planti
//
//  Created by Dominik Wieners on 30.01.21.
//

import SwiftUI

struct MissionInactiveItemView: View {
    
    @EnvironmentObject var missionViewModel: MissionsViewModel
    
    let inactiveMissions: [MyInactiveMission]
    
    var body: some View {
        ForEach(inactiveMissions) { item in
            NavigationLink(
                destination: MissionDetailView(navTitle: item.title, missionId: item.id),
                label: {
                    HStack {
                        LazyVStack(alignment: .leading) {
                            Text(item.title).font(.headline)
                                .foregroundColor(.primary)
                                .padding(.bottom, 2)
                            Text(item.description).font(.subheadline).foregroundColor(.secondary)
                            Spacer()
                        }.padding(.trailing, 8)
                        
                    }.padding(.vertical)
                }).buttonStyle(PlainButtonStyle())
     
        }
    }
}

struct MissionInactiveItemView_Previews: PreviewProvider {
    static var previews: some View {
        MissionInactiveItemView(inactiveMissions: myMissionsExample.inactive)
            .environmentObject(MissionsViewModel())
            .previewAsComponent()
    }
}
