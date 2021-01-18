//
//  SelectionContentView.swift
//  Planti
//
//  Created by Dominik Wieners on 12.01.21.
//

import SwiftUI

struct SelectionContentView: View {
    
    
    @EnvironmentObject private var selectionViewModel: SelectionViewModel
    @EnvironmentObject private var plantiNetViewModel: PlantiNetViewModel
    
    @State private var isLoading = false
    @State private var spin = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View{
        VStack{
            ImagePreview(uiImage: $selectionViewModel.flowerImage)
                .padding()
            ZStack{
                LazyVStack{
                    ImageSourceButton(activeSheet: $selectionViewModel.imageSheet)
                }.zIndex(2)
                LazyVStack(alignment: .trailing) {
                    Button(action: {
                        if let image = selectionViewModel.flowerImage {
                            plantiNetViewModel.classifyImage(uiImage: image)
                        }
                    }){
                        if isLoading {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.white)
                                .rotationEffect(Angle(degrees: spin ? 360.0 : 0))
                                .animation(foreverAnimation)
                                .onDisappear(perform: {
                                    self.spin = false
                                })
                                .onAppear(perform: {
                                    self.spin = true
                                })
                        } else {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(16)
                    .background( Color.green)
                    .mask(Capsule())
                    .padding()
                    .onReceive(plantiNetViewModel.$isLoading, perform: { v in
                        withAnimation(.default) {
                            isLoading = v
                        }
                    })
                    .zIndex(1)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .bottomLeading)
            
            
        }
    }
    
    
}
struct SelectionContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionContentView()
            .environmentObject(SelectionViewModel())
            .environmentObject(PlantiNetViewModel())
    }
}
