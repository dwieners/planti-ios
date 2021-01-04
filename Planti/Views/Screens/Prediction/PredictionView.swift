//
//  ClassifiedView.swift
//  Planti
//
//  Created by Dominik Wieners on 11.12.20.
//

import SwiftUI

struct PredictionView: View {
    
    var prediction: PlantPrediction?
    @State private var plantInfo: PlantInfo?
    
    

    func loadInfo(label: String){
        PlantiService.shared.info(label: label) { res in
            print(res)
            switch (res){
            case .failure(let err):
                print(err.localizedDescription)
                break;
            case .success(let info):
                self.plantInfo = info
                print(info)
            }
            
        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let plantInfo = plantInfo, let pre = prediction {
                    LazyVStack(alignment: .leading){
                        HStack{
                        Text(plantInfo.title).font(.title).foregroundColor(.white)
                            Spacer()
                            Text("\(Double(pre.prediction)!, specifier: "%.0f")%").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.black)
                    Text(plantInfo.description).font(.body).padding()
                } else {
                    Text("No Prediction")
                }
            }
            .frame(width: .infinity)
            .navigationTitle("Ergebnis")
            .onAppear(perform: {
                guard let pre = prediction else { return }
                loadInfo(label: pre.label)
            })
        }
        
        
    }
}

struct ClassifiedView_Previews: PreviewProvider {
    static var previews: some View {
        let prediction = PlantPrediction(label: "allium_ursinum", prediction: "89.01829528808594")
        NavigationView {
            PredictionView(prediction: prediction)
        }.navigationBarTitle("Ergebnis", displayMode: .inline)
    }
}
