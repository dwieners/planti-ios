//
//  MissionEmptyView.swift
//  Planti
//
//  Created by Dominik Wieners on 30.01.21.
//

import SwiftUI



enum MissionEmptyType: String, CaseIterable, Codable {
    var id: Int {
        self.hashValue
    }
    case NO_ACTIVE_MISSIONS
    case NO_INACTIVE_MISSIONS
}



func getImage(by missionEmptyType: MissionEmptyType) -> Image{
    switch missionEmptyType {
    case .NO_ACTIVE_MISSIONS:
        return Image("sad-girl")
    case .NO_INACTIVE_MISSIONS:
        return Image("happiness")
        
    }
}

struct MissionEmptyView: View {
    
    var type: MissionEmptyType
    var description: String
    
    var body: some View {
            HStack {
                getImage(by: type).resizable().scaledToFit().frame(height: 100).padding()
                Text(description).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
            }
        
    }
}

struct MissionEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MissionEmptyView(type: .NO_INACTIVE_MISSIONS, description: "Alle Missionen sind aktiv")
            .previewLayout(.sizeThatFits)
    }
}
