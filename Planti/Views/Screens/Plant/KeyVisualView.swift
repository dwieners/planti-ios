//
//  KeyVisualView.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import SwiftUI

struct KeyVisualView: View {
    
    var imageUrl:String
    var uiImage : Binding<UIImage?>?
    
    
    @State private var image: UIImage = UIImage()
    @State private var opacity: Double = 0
    @ObservedObject private var imageLoader: ImageLoader
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        self.imageLoader = ImageLoader(urlString: imageUrl)
    }
    
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .onReceive(imageLoader.didChange){ data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

struct KeyVisualView_Previews: PreviewProvider {
    static var previews: some View {
        KeyVisualView(imageUrl: "http://192.168.0.80:5000/api/plants/images/bellis_perennis.png")
    }
}
