//
//  InventoryItemView.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct InventoryItemView: View {
    
    var item: MyInventoryItem
    
    var data = [
        MyAchievementItem(id: 0, name: "Standard", description: "Blub", type: .STANDARD),
      
    ]
    
    var scoreView: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(item.score_to_unlock) Punkte")
                    .font(.body)
                    .bold()
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10, corners:[ .topRight, .bottomLeft])
            }
            Spacer()
        }.zIndex(1)
    }
    
    
    var body: some View {
        LazyVStack {
            ZStack {
                AchievementItemView(name: item.name, type: item.type)
                    .opacity(item.unlocked ? 1 : 0.25)
                    .zIndex(0)
                if item.unlocked {
                    EmptyView()
                }else {
                    scoreView
                }
            }
        }
    }
}

struct InventoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InventoryItemView(item: MyInventoryItem(id: 1, name: "Hexenhut", description: "Beispieltext", score_to_unlock: 100, type: .STANDARD, unlocked: true))
                .previewLayout(.sizeThatFits)
            InventoryItemView(item: MyInventoryItem(id: 1, name: "Hexenhut", description: "Beispieltext", score_to_unlock: 100, type: .HORNS_HAT, unlocked: false))
                .previewLayout(.sizeThatFits)
                
        }
       
    }
}
