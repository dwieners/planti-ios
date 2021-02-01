//
//  MissionTargetViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 01.02.21.
//

import Foundation

enum MissionTargetStatusSheet : Identifiable {
    var id: Int {
        self.hashValue
    }
    case missionTargetComplete
}



class MissionTargetViewModel: ObservableObject {
    
    @Published var completedTarget: MyMissionTargetCompleteStatus?
    @Published var missionTargetStatusSheet: MissionTargetStatusSheet?
    @Published var missionsUpToDate:Bool = false
    
    func checkMissions(key: String){
        ProfileService.shared.completeMissionTarget(key: key) { (res) in
            switch res {
            case .success(let mission):
                self.completedTarget = mission
                self.missionTargetStatusSheet = .missionTargetComplete
                self.missionsUpToDate = false
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.missionsUpToDate = true
            }
        }  urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }
        
    }
    
    
}
