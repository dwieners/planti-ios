//
//  HomePlaceholderView.swift
//  Planti
//
//  Created by Dominik Wieners on 27.01.21.
//

import SwiftUI

struct HomePlaceholderView: View {
    
    
    // Views
    
    var placeholderImage: some View {
        Image("plant").resizable().scaledToFit().frame(width: UIScreen.main.bounds.width * 0.5)
    }
    
    
    var placeholderText: some View {
        Text("Du hast noch keine Pflanzen gefunden.")
            .padding(.top, 16)
            .font(.system(size: 17, weight: .heavy, design: .default))
            .multilineTextAlignment(.center)
            .lineLimit(50)
            .frame(width: UIScreen.main.bounds.width * 0.7)
    }
    
    
    
    var body: some View {
        VStack{
            placeholderImage
            placeholderText
        }.offset(CGSize(width: 0, height: -44))
    }
}

struct HomePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        HomePlaceholderView()
    }
}
