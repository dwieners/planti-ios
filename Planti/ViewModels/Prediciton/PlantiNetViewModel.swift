//
//  PlantiNetViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import Foundation
import UIKit
class PlantiNetViewModel : ObservableObject {
    
    @Published var predictions : PlantPredicationResult?
    
    @Published var isLoading : Bool = false
    
    @Published var hasPrediction : Bool = false
    
    
    /// Classify Image with PlantiNet ML Model
    /// - Parameter image: UImage
    func classifyImage(uiImage: UIImage){
        self.isLoading = true
        ClassificationService.shared.classify(with: uiImage) { res in
            switch (res){
            case .failure(let err):
                print(err.localizedDescription)
                self.isLoading = false
                break;
            case .success(let plant):
                print(plant)
                self.predictions = plant
                if let prediction = plant.predictions.first {
                    debugPrint("🌼 [Predictions]: BEST (\(prediction))")
                }
                self.hasPrediction = true
                self.isLoading = false
            }
        }
    }
    
    
    /// Reset Predictions
    func resetPredictions() {
        self.predictions = nil
    }
    
    
}
