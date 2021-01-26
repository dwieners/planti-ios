//
//  RankingViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation


class RankingViewModel: ObservableObject {
    
    
    @Published var rankings = [UserRanking]()
    
    
    
    func loadUserRankings(){
        
        RankingService.shared.load_ranking() { res in
            switch (res) {
            case .success(let rankings):
                print(rankings)
                self.rankings = rankings
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        } urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }
        
    }
}
