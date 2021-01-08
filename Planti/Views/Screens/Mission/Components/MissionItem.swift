//
//  MissionItem.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

struct MissionItem: View {
    
    var mission: Mission
    
    var body: some View {
        LazyVStack(spacing: 32){
            HStack{
                Text(mission.title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.label)
                
                Spacer(minLength: 0)
            }
            CircularProgressView(color: mission.color, currentData: mission.currentData, goal: mission.goal)
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
    
}

struct MissionViewItem_Previews: PreviewProvider {
    static var previews: some View {
        MissionItem(mission: Mission(id: 1, title: "Heilkräuter", currentData: 10, goal: 100, color: .blue))
            .previewAsComponent()
    }
}
