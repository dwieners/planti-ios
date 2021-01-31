//
//  RankingViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation


class RankingViewModel: ObservableObject {
    
    
    @Published var rankings = [UserRanking]()
    @Published var isLoading: Bool = false
    
    
    
    func loadUserRankings(){
        self.isLoading = true
        RankingService.shared.load_ranking() { res in
            switch (res) {
            case .success(let rankings):
                print(rankings)
                self.rankings = rankings
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
                
            }
        } urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }
        
    }
}
