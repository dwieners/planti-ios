//
//  RestView.swift
//  Planti
//
//  Created by Dominik Wieners on 22.11.20.
//

import SwiftUI

struct ImageSelectionRestView: View {
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingCameraMode = false
    
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
                showingCameraMode = false
                showingImagePicker.toggle()
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
                showingCameraMode = true
                showingImagePicker.toggle()
            }) {
                HStack{
                    Image(systemName: "camera")
                    Text("Hallo")
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(8)
                .padding(.horizontal)
                .foregroundColor(.white)
            }
        }
        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerView(sourceType: showingCameraMode ? .camera : .photoLibrary, image: $inputImage)
        }
        .navigationTitle("Rest API")
    }
}

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ImageSelectionRestView()
        }
    }
}
