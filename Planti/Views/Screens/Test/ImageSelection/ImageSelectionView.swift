//
//  RestView.swift
//  Planti
//
//  Created by Dominik Wieners on 22.11.20.
//

import SwiftUI
import CoreML

enum ImageSelectionSheet: Identifiable {
    var id: Int {
        self.hashValue
    }
    case picker
    case camera
}



struct ImageSelectionView: View {
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    @State private var imageSelectionSheet: ImageSelectionSheet?
    @State private var classificationLabel: String?
    @State private var showClassifyerScreen = false
    
    let model: MobileNetV2 = {
        do {
            let config = MLModelConfiguration()
            return try MobileNetV2(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn't create MobileNetV2")
        }
    }()
    
    private func performImageClassification(){
        guard let img = inputImage else { return}
        let resizedImage = img.resizeTo(size: CGSize(width: 224, height: 224))
        guard let buffer = resizedImage.toCVPixelBuffer() else {
            return
        }
        
        let output = try? model.prediction(image: buffer)
        
        classificationLabel = output?.classLabel
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            if let i = image {
                i
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .padding(.all)
            } else {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.all)
                    .background(Color.secondarySystemBackground)
                    .cornerRadius(8)
        
            }
            Spacer()
            Button(action: {
                self.imageSelectionSheet = .camera
            }) {
                HStack{
                     Image(systemName: "photo")
                     Text("Bild aus der Gallerie wählen")
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(8)
                .padding([.horizontal, .bottom])
                .foregroundColor(.white)
            }
          
            Button(action: {
                self.imageSelectionSheet = .picker
            }) {
                HStack{
                    Image(systemName: "camera")
                    Text("Foto machen")
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(8)
                .padding([.horizontal, .bottom])
                .foregroundColor(.white)
            }
            
          
            
            NavigationLink(
                destination: Text(classificationLabel ?? "Kein Ergebnis"),
                isActive: $showClassifyerScreen,
                label: {
                    Button(action: {
                        performImageClassification()
                        showClassifyerScreen.toggle()
                    }) {
                        HStack{
                            Image(systemName: "graduationcap")
                            Text("Klassifizieren")
                            Spacer()
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    }
                })
            
        }
        .fullScreenCover(item: $imageSelectionSheet, onDismiss: loadImage) { (item:ImageSelectionSheet) in
            switch(item) {
            case .picker:
                ImagePickerView(sourceType: .photoLibrary, image: $inputImage)
                    .accentColor(.green)
            case .camera:
                ImagePickerView(sourceType: .camera , image: $inputImage)
                    .accentColor(.green)
            }
           
            
        }
        .navigationTitle("Gallery & Image")
    }
}

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ImageSelectionView()
        }
    }
}
