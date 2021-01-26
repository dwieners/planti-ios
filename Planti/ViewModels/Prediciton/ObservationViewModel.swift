//
//  ObservationViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper

enum PlantViewAlerts: Identifiable {
    var id: Int {
        self.hashValue
    }
    case sendObservation
    case hasSendObservation
    case dailyPoints
    case unlockedMission
}

class ObservationViewModel: ObservableObject {
    
    @Published var message: StandardResponseMessage?
    @Published var isLoading: Bool = false
    @Published var plantViewAlert: PlantViewAlerts?
    
    
    func getDailyBonus(){
        self.isLoading = true
        ProfileService.shared.getDailyScore { res in
            switch (res) {
            case .success(let resMessage):
                self.isLoading = false
                debugPrint("💰 [Get Daily Bonus]: \(resMessage.message)")
                self.plantViewAlert = .dailyPoints
            case.failure(let error):
                self.isLoading = false
                debugPrint(error.localizedDescription)
            }
        } urlResponse: { urlRes in
            debugPrint("🌎[\(urlRes.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: urlRes.statusCode ))")
        }

    }
    
    func uploadObservation(uiImage: UIImage, key: String, latitude: Double, longitude: Double){
        self.isLoading = true
        ObservationService.shared.observation(with: uiImage, key: key, latitude: latitude, longitude: longitude) { res in
            switch (res) {
            case .success(let message):
                self.isLoading = false
                self.message = message
                self.plantViewAlert = .hasSendObservation
                debugPrint("👀 [NEW OBSERVATION] Successfull upload data")
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
            
        }
        
    }
    
    
}
