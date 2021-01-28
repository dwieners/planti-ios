//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 17.11.20.
//

import SwiftUI

struct TestView: View {
    
    @State private var showModalView = false
    
    
    // Views
    var cameraLiveView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text("Kamera Live").foregroundColor(.white)
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
        .cardContained(background: .green, cornerRadius: 8)
        .padding([.top, .horizontal])
    }
    
    var galleryAndCamera: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text("Gallerie & Kamera")
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
        .cardContained()
        .padding([.top, .horizontal])
    }
    
    
    var body: some View {
        ScrollView {
            NavigationLink(
                destination: CameraLiveView()
            ){
                cameraLiveView
            }
            NavigationLink(
                destination: ImageSelectionView()
            ){
                galleryAndCamera
            }
            .navigationTitle(Text("Tests"))
        }
    }
    
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
