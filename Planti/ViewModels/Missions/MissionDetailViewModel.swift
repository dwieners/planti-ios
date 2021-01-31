//
//  MissionDetailViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import Foundation


enum MissionDetailAlert: Identifiable {
    var id: Int {
        self.hashValue
    }
    case missionIsActive
}



class MissionDetailViewModel: ObservableObject {
    
    @Published var missionInfoStatus: MyMissionInfoStatus?
    @Published var missionDetailAlert: MissionDetailAlert?
    @Published var isLoading:Bool = false
    
    
    func loadMissionStatus(missionId: Int){
        self.isLoading = true
        ProfileService.shared.loadMissionStatus(mission_id: missionId) { res in
            switch res {
            case .success(let myMissionInfoStatus):
                self.missionInfoStatus = myMissionInfoStatus
                self.isLoading = false
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
            }
        }  urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }
    }
    
    func activateMissionStatus(missionId: Int){
        ProfileService.shared.activateMission(mission_id: missionId) {res in
            switch res {
            case .success(let activationStatus):
                debugPrint("✅ [MISSION ACTIVATED]: \(activationStatus.message)")
                self.missionDetailAlert = .missionIsActive
                self.loadMissionStatus(missionId: missionId)
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
