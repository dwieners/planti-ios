//
//  AvatarKeyVisual.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct AvatarKeyVisual: View {
    
    var figureType: FigureType
    
    var body: some View {
        VStack {
            getImage(by: figureType)
                .resizable()
                .scaledToFit()
                .frame(height: 175)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(Color.secondarySystemBackground)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct AvatarKeyVisual_Previews: PreviewProvider {
    static var previews: some View {
        AvatarKeyVisual(figureType: .WITCH).previewAsComponent()
    }
}
