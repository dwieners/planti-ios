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
    var item: PlantShape
    
    @State var selection: Tab = .flower
    @State private var activeSheet: Sheet?
    @State private var inputFlower: UIImage?
    @State private var inputLeaf: UIImage?
    @State private var hasFinalPrediction = false
    
    @Binding var predictionSheet: Sheet?
    @EnvironmentObject private var plantiNetViewModel: PlantiNetViewModel

    var body: some View {
        
        VStack(alignment: .leading) {
            TabView(selection: $selection){
                VStack{
                    InfoCard(image: Image(systemName: "stethoscope"), text: "Fotografiere die gesamte blüte als Draufsicht")
                        .padding()
                    
                    SelectionContentView(
                        type: $selection,
                        selectedImage: $inputFlower,
                        activeSheet: $activeSheet
                    )
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            NavigationLink(destination: PredictionView(predictionSheet: $predictionSheet), isActive: $plantiNetViewModel.hasPrediction){
               Spacer().fixedSize()
            }
            
        }
        .navigationBarTitle(item.title, displayMode: .inline)
        .background(Color.secondarySystemBackground.ignoresSafeArea(.all))
        .fullScreenCover(item: $activeSheet){ item in
            if selection == Tab.flower {
                if item == .picker {
                    ImagePickerView( sourceType: .photoLibrary, image: $inputFlower)
                }
                if item == .camera {
                    ImagePickerView( sourceType: .camera , image: $inputFlower)
                }
            }
            
            if selection == Tab.leaf {
                if item == .picker {
                    ImagePickerView( sourceType: .photoLibrary, image: $inputLeaf)
                }
                if item == .camera {
                    ImagePickerView( sourceType: .camera , image: $inputLeaf)
                }
            }
            
           
        }
    
    }
    
}





struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SelectionView(item: PlantShape(title: "Blüte", keyVisual: "flower"), predictionSheet: .constant(nil))
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
