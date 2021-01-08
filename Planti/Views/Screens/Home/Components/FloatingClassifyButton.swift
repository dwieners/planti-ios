//
//  FloatingClassifyButton.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct FloatingClassifyButton: View {
    
    var image: Image
    var label: String
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        Button(action: {
           activeSheet = .selection
        }, label: {
            LazyVStack{
                HStack{
                    image
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(label)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(0)
                }
            }.frame(height: 50)
        })
        .background(Color.green)
        .cornerRadius(25)
    }
}

struct FloatingClassifyButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingClassifyButton(image: Image(systemName: "camera.viewfinder"), label: "Pflanze bestimmen", activeSheet: .constant(nil)).previewAsComponent()
    }
}
