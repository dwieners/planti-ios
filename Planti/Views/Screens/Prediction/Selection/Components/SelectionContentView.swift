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

 
    func checkAndUploadImage(){
        if let image = selectionViewModel.flowerImage {
            plantiNetViewModel.checkPlant(uiImage: image)
            if plantiNetViewModel.isPlant {
                plantiNetViewModel.classifyImage(uiImage: image)
            }else{
                selectionViewModel.selectionSheet = .invalid
            }
        } else {
            selectionViewModel.selectionAlerts = .emptyImage
        }
    }
    
    // Views
    var buttomActionsView: some View {
        ZStack{
            LazyVStack{
                ImageSourceButton(activeSheet: $selectionViewModel.selectionSheet)
            }.zIndex(2)
            LazyVStack(alignment: .trailing) {
                CirculaLoadingButton(action: checkAndUploadImage, isLoading: $plantiNetViewModel.isLoading)
                    .padding()
                    .zIndex(1)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               alignment: .bottomLeading)
    }

    var body: some View{
        VStack{
            ImagePreview(uiImage: $selectionViewModel.flowerImage)
                .padding() 
            buttomActionsView
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
