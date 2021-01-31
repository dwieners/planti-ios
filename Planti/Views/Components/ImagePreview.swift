//
//  ImagePreview.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI
import UIKit


struct ImagePreview: View {
    
    @Binding var uiImage: UIImage?
    
    var body: some View {
        VStack(alignment: .center) {
            if let inputImage = uiImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.1)

            }
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreview(uiImage: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
