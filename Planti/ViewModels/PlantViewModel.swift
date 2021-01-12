//
//  PlantViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import Foundation


class PlantViewModel: ObservableObject {
    
    @Published var plant: PlantInfo?
    @Published var isLoading = false
    
    func loadInfo(key: String){
        isLoading = true
        PlantiService.shared.info(key: key){ res in
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
        }
    }
    
}
