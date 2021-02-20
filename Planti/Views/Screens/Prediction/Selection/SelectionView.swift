//
//  RestSelectionView.swift
//  Planti
//
//  Created by Dominik Wieners on 01.12.20.
//

import SwiftUI
import UIKit




struct SelectionView: View {
    
    
    @EnvironmentObject private var selectionViewModel: SelectionViewModel
    @EnvironmentObject private var plantiNetViewModel: PlantiNetViewModel
    
    @Binding var predictionSheet: Sheet?
    
    // Actions
    func getTitle(plantShape: PlantShape?) -> String {
        if let shape = plantShape {
            return shape.title
        }else {
            return "Unbekannt"
        }
    }
    
    func demo(plantShape: PlantShape?) -> Bool {
        if let ps = plantShape {
            switch ps.type {
            case.wildflower :
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    var body: some View {
        if demo(plantShape: selectionViewModel.plantShape) {
            VStack(alignment: .leading) {
                TabView(selection: $selectionViewModel.selection){
                    VStack{
                        InfoCard(image: Image("stethoscope"), text: "Fotografiere die gesamte Blüte als Draufsicht.")
                            .padding()
                        SelectionContentView()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                
                NavigationLink(destination: PredictionView(predictionSheet: $predictionSheet), isActive: $plantiNetViewModel.hasPrediction){
                    Spacer().fixedSize()
                }
                
            }
            .navigationBarTitle( getTitle(plantShape: selectionViewModel.plantShape) , displayMode: .inline)
            .background(Color.secondarySystemBackground.ignoresSafeArea(.all))
            .alert(item: $selectionViewModel.selectionAlerts, content: { (item:SelectionAlert) -> Alert in
                switch item {
                case .emptyImage:
                    return Alert(title: Text("Bitte lade ein Bild hoch"))
                }
            })
            .fullScreenCover(item: $selectionViewModel.selectionSheet){ (item:SelectionSheet) in
                switch item {
                case .picker:
                    ImagePickerView( sourceType: .photoLibrary, image: $selectionViewModel.flowerImage)
                        .accentColor(.green)
                case .camera:
                    ImagePickerView( sourceType: .camera , image: $selectionViewModel.flowerImage)
                        .accentColor(.green)
                case .invalid:
                    InvalidPredictionView(selectionSheet: $selectionViewModel.selectionSheet)
                }
                
            }
        }else{
            Text("🚧 Hier wird noch gebaut.")
                .navigationBarTitle( getTitle(plantShape: selectionViewModel.plantShape) , displayMode: .inline)
        }
        
    }
    
}





struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SelectionView( predictionSheet: .constant(nil))
                .environmentObject(SelectionViewModel())
                .environmentObject(PlantiNetViewModel())
        }
        .accentColor(.green)
    }
}


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
