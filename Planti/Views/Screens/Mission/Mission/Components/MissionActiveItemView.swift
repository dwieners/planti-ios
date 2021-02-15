//
//  MissionActiveItemView.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import SwiftUI

struct MissionActiveItemView: View {
    
    var item: MyActiveMission
    
    var body: some View {
        HStack {
            LazyVStack(alignment: .leading) {
                Text(item.title).font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 2)
                    .font(.system(size: 22))
                Text(item.description).font(.subheadline).foregroundColor(.secondary)          .font(.system(size: 22))
                Spacer()
            }.padding(.trailing, 8)
            CircularProgressView(color: .label, currentData: CGFloat(item.complete_targets), goal: CGFloat(item.total_targets))
                .padding(.trailing, 8)
        }.padding(.vertical)
    }
}

struct MissionActiveItemView_Previews: PreviewProvider {
    static var previews: some View {
        MissionActiveItemView(
            item: MyActiveMission(
                id: 1,
                image_url: nil,
                title: "Blüten",
                description: "Finde alle Blüten in deiner Umgebung",
                complete_targets: 3,
                total_targets: 5)).previewAsComponent()
    }
}
