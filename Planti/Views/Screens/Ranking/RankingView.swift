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
    
    
    var items: Array<EnumeratedSequence<[UserRanking]>.Element> {
        return Array(rankingViewModel.rankings.enumerated())
    }
    

    var body: some View {
        VStack {
            if rankingViewModel.isLoading {
                PlantiIndicatorView()
            } else {
                List {
                    ForEach(items, id: \.offset){ index, item in
                        RankingRowView(index: index, item: item)
                    }
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
