//
//  RankingView.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import SwiftUI

struct RankingView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var rankingViewModel: RankingViewModel
    
    var body: some View {
        List {
            ForEach(Array(rankingViewModel.rankings.enumerated()), id: \.offset){ index, item in
                if !item.is_current {
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 32, height: 32)
                            .background(Color.secondarySystemBackground)
                            .mask(Circle())
                            .foregroundColor(Color.label)
                        Text(item.user.username).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal)
                        Spacer()
                        Text("\(item.user.score) 💰")
                    }.padding(.vertical)
                } else {
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 32, height: 32)
                            .background(Color.label)
                            .mask(Circle())
                            .foregroundColor(Color.secondarySystemBackground)
                        Text(item.user.username).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal)
                        Spacer()
                        Text("\(item.user.score) 💰")
                    }.padding(.vertical)
                }
                  
            }
        }
        .navigationBarTitle("Rangliste")
        .onAppear(perform: {
            rankingViewModel.loadUserRankings()
        })
      
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RankingView()
                .environmentObject(RankingViewModel())
        }
    }
}
