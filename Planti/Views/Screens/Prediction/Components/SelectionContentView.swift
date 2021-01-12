//
//  SelectionContentView.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import SwiftUI

struct SelectionContentView: View {
    @Binding var type: Tab
    @Binding var selectedImage: UIImage?
    @Binding var activeSheet:Sheet?
    
    @EnvironmentObject private var plantiNetViewModel: PlantiNetViewModel
   
  
    var body: some View{
        VStack{
            ImagePreview(uiImage: $selectedImage)
            .padding()
            ZStack{
                LazyVStack{
                    ImageSourceButton(activeSheet: $activeSheet)
                }
                LazyVStack(alignment: .trailing) {
                    Button(action: {
                        if let image = selectedImage {
                            plantiNetViewModel.classifyImage(image: image)
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundColor(.white)
                          
                    })
                    .padding(16)
                    .background(Color.green)
                    .mask(Capsule())
                    .padding()
                }
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .bottomLeading)
       
        }
    }
    
    
}
struct SelectionContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionContentView(
            type: .constant(.flower),
            selectedImage: .constant(UIImage(systemName: "flower")!),
            activeSheet: .constant(.picker)
        )
    }
}
