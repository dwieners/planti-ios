//
//  PlantViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import Foundation
import UIKit
import CoreLocation


class PlantViewModel: ObservableObject {
    
    @Published var plant: PlantInfo?
    @Published var isLoading = false
    
   
    
    func loadInfo(key: String){
        isLoading = true
        PlantService.shared.details(key: key){ res in
            switch (res) {
            case .success(let info):
                self.plant = info
                self.isLoading = false
                break;
            case .failure(let error):
                print(error)
                self.isLoading = false
                break;
            }
        } urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }

       
    }
    
}
