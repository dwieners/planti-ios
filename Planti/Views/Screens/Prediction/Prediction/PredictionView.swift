//
//  ClassifiedView.swift
//  Planti
//
//  Created by Dominik Wieners on 11.12.20.
//

import SwiftUI

struct PredictionView: View {
    
    @EnvironmentObject var selectionViewModel: SelectionViewModel
    @EnvironmentObject var plantiNetViewModel: PlantiNetViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @Binding var predictionSheet: Sheet?

    
    
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
        
        
        ScrollView{
            InfoCard(image: Image("check-mark"), text: "Toll gemacht! Wir haben ein Ergebnis erzielt!")
                .padding()
            
            
            ForEach(loadPlantPredictionResult(item: plantiNetViewModel), id: \.id) { result in
                NavigationLink(
                    destination: PlantView(key: result.item.key, location: selectionViewModel.location, selectedImage: selectionViewModel.flowerImage, predictionSheet: $predictionSheet)
                        .environmentObject(PlantViewModel())
                    ,
                    label: {
                        
                        LazyVStack(alignment: .leading) {
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(result.item.title).font(.headline).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(result.item.scientific_name).font(.subheadline)
                                }
                                Spacer()
                                Text("\(String(format: "%.5f%", result.prediction)) %")
                                
                            }
                            .foregroundColor(.label)
                            .padding([.horizontal])
                            
                        }
                        
                    })
                Divider()
                
                
            }
            
        }
        .navigationBarTitle("Ergebnis", displayMode: .inline)
        .onAppear(perform: {
            locationManager.stopUpdating()
        })
        .navigationBarBackButtonHidden(true)
        .accentColor(.green)
        .background(Color.secondarySystemBackground.ignoresSafeArea())
        
  
    }
}

struct ClassifiedView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        NavigationView {
            PredictionView(predictionSheet: .constant(nil))
                .environmentObject(PlantiNetViewModel())
                .environmentObject(SelectionViewModel())
                .environmentObject(LocationManager())
        }
        .navigationBarTitle("Ergebnis", displayMode: .inline)
    }
}