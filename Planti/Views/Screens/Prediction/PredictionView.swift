//
//  ClassifiedView.swift
//  Planti
//
//  Created by Dominik Wieners on 11.12.20.
//

import SwiftUI

struct PredictionView: View {
    @Binding var predictionSheet: Sheet?
    @EnvironmentObject var plantiNetViewModel: PlantiNetViewModel
 
    
    func formatPrediction(prediction: Double) -> String {
        return String(format: "%.5f", prediction)
    }
    
    func loadPlantPredictionResult(item: PlantiNetViewModel) -> [PlantPrediction] {
        if let predictions = plantiNetViewModel.predictions {
            print(predictions)
            return predictions.predictions
        }else{
            return []
        }
    }
    
    var body: some View {
        VStack{
            ForEach(loadPlantPredictionResult(item: plantiNetViewModel), id: \.id) { result in
                Text("Result: \(result.item.title)")
            }
                
        }
        .navigationBarTitle("Ergebnis", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            predictionSheet = nil
        }, label: {
            Text("Fertig")
        }))
        .accentColor(.green)
     
    }
}

struct ClassifiedView_Previews: PreviewProvider {

    
    static var previews: some View {
        NavigationView {
            PredictionView(predictionSheet: .constant(nil))
                .environmentObject(PlantiNetViewModel())
        }
        .navigationBarTitle("Ergebnis", displayMode: .inline)
    }
}
