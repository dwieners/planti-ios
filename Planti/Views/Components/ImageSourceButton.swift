//
//  ImageSourceButton.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct ImageSourceButton: View {
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    activeSheet = .camera
                }
                , label: {
                    Image(systemName: "camera.fill").resizable().scaledToFit().frame(height: 32)
                })
                .padding(32)
                .background(Color.tertiarySystemBackground)
                .foregroundColor(.label)
                .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                
                
                Button(action: {
                    activeSheet = .picker
                }
                , label: {
                    Image(systemName: "photo.fill.on.rectangle.fill").resizable().scaledToFit().frame(height: 32)
                })
                .padding(32)
                .background(Color.tertiarySystemBackground)
                .foregroundColor(.label)
                .cornerRadius(20, corners: [.topRight, .bottomRight])
            }.padding()
        } .frame( maxWidth: .infinity)
    }
}

struct ImageSourceButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageSourceButton(activeSheet: .constant(nil))
            .previewAsComponent()
    }
}
