//
//  RestSelectionView.swift
//  Planti
//
//  Created by Dominik Wieners on 01.12.20.
//

import SwiftUI



enum Tab {
    case flower
    case leaf
}




struct SelectionView: View {
    
    
    @EnvironmentObject private var selectionViewModel: SelectionViewModel
    @EnvironmentObject private var plantiNetViewModel: PlantiNetViewModel

    @Binding var predictionSheet: Sheet?
    
    
    
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
                        InfoCard(image: Image(systemName: "stethoscope"), text: "Fotografiere die gesamte blüte als Draufsicht")
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
            .fullScreenCover(item: $selectionViewModel.imageSheet){ item in
                if selectionViewModel.selection == Tab.flower {
                    if item == .picker {
                        ImagePickerView( sourceType: .photoLibrary, image: $selectionViewModel.flowerImage)
                    }
                    if item == .camera {
                        ImagePickerView( sourceType: .camera , image: $selectionViewModel.flowerImage)
                    }
                }
            }
        }else{
            Text("🚧 Hier wird noch gebaut")
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
