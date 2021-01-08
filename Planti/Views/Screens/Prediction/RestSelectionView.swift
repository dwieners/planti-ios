//
//  RestSelectionView.swift
//  Planti
//
//  Created by Dominik Wieners on 01.12.20.
//

import SwiftUI



struct RestSelectionView: View {
    var item: PlantShape
    @State private var activeSheet: Sheet?
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    @State private var classifiedItem: PlantPrediction?
    @State private var hasPrediction = false
    
    
    //    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary:
    //    }
    
    func classifyImage(){
        if let selectedImage = inputImage {
            PlantiService.shared.classify(withImage: selectedImage) { res in
                switch (res){
                case .failure(let err):
                    print(err.localizedDescription)
                    break;
                case .success(let plant):
                    self.classifiedItem = plant.predictions.first
                    self.hasPrediction = true
                }
            }
        }
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            InfoCard(image: Image(systemName: "stethoscope"), text: "Gerne untersuchen wir deine Entdeckte Pflanze. Mache hierzu einfach ein Foto oder Verwende eines aus deiner Gallerie.")
            .padding()
            
            ImagePreview(uiImage: $inputImage)
            .padding()

            ImageSourceButton(activeSheet: $activeSheet)
            
            NavigationLink(destination: PredictionView(prediction: classifiedItem), isActive: $hasPrediction){
               Spacer().fixedSize()
            }
            
            
        }
        .navigationBarTitle(item.title, displayMode: .inline)
        .navigationBarItems(trailing:
                Button(action: {
                    classifyImage()
                }, label: {
                    Text("Bestimmen")
                })
        )
        .background(Color.secondarySystemBackground.ignoresSafeArea(.all))
        .fullScreenCover(item: $activeSheet){ item in
            if item == .picker {
                ImagePickerView( sourceType: .photoLibrary, image: $inputImage)
            }
            
            if item == .camera {
                ImagePickerView( sourceType: .camera , image: $inputImage)
            }
        }
        
        
//        .fullScreenCover(isPresented: $showingImagePicker) {
//            ImagePickerView(sourceType: showingCameraMode ? .camera : .photoLibrary, image: $inputImage)
//        }
    }
    
    
    
    
}



struct RestSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RestSelectionView(item: PlantShape(title: "Blüte", keyVisual: "flower"))
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
