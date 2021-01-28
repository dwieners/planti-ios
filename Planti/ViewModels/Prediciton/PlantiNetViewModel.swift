//
//  PlantiNetViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import Foundation
import UIKit
import CoreML






class PlantiNetViewModel : ObservableObject {
    
    @Published var predictions : PlantPredicationResult?
    @Published var isLoading : Bool = false
    @Published var hasPrediction : Bool = false
    @Published var isPlant : Bool = true
    
    
    let model: PlantDetector = {
        do {
            let config = MLModelConfiguration()
            return try PlantDetector(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create PlantDetector")
        }
    }()
    
    
    func checkPlant(uiImage: UIImage){
        let resizedImage = uiImage.resizeTo(size: CGSize(width: 224, height: 224))
        guard let buffer = resizedImage.toCVPixelBuffer() else { return }
        let output = try? model.prediction(image: buffer)
        if let output = output {
            switch (output.classLabel) {
            case "is_plant" :
                self.isPlant = true
                break
            default:
                self.isPlant = false
            }
        }
    }
    
    
    
    /// Classify Image with PlantiNet ML Model
    /// - Parameter image: UImage
    func classifyImage(uiImage: UIImage){
        self.isLoading = true
        ClassificationService.shared.classify(with: uiImage) { res in
            switch (res){
            case .failure(let err):
                debugPrint(err.localizedDescription)
                self.isLoading = false
                break;
            case .success(let plant):
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
