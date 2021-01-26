//
//  PlantOverviewViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 13.01.21.
//

import Foundation
import SwiftUI
import Combine

class PlantOverviewViewModel : ObservableObject {
    
    @Published var plants: [PlantItem] = []
  
    @Published var isLoading : Bool = false
    
    func loadOverview(){
        PlantService.shared.overview{ res in
            switch(res){
            case .failure(let err):
                print(err.localizedDescription)
                self.isLoading = false
                break;
            case .success(let items):
                self.plants = items
                break
           
            }
        }
    }
    
}
