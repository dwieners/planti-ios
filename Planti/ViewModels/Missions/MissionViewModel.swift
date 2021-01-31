//
//  MissionViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 30.01.21.
//

import Foundation

class MissionsViewModel: ObservableObject {
    
    
    @Published var myMissions: MyMissions?
    @Published var isLoading: Bool = false
    
    
    func loadMyMission(){
        self.isLoading = true
        ProfileService.shared.loadMissions { res in
            switch res {
            case .success(let myMissions):
                self.myMissions = myMissions
                self.isLoading = false
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
            }
        }  urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }

    }
    
}
