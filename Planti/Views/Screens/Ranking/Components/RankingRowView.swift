//
//  RankingRowView.swift
//  Planti
//
//  Created by Dominik Wieners on 27.01.21.
//

import SwiftUI

struct RankingRowView: View {
    
    var index: Int
    
    var item: UserRanking
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
                .frame(width: 32, height: 32)
                .background(item.is_current ?  Color.label : Color.secondarySystemBackground)
                .mask(Circle())
                .foregroundColor(item.is_current ?  Color.secondarySystemBackground : Color.label)
            Text(item.user.username)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            Spacer()
            Text("\(item.user.score) 💰")
        }.padding(.vertical)
    }
}

