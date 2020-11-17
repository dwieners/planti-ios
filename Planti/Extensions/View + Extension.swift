//
//  View + Extension.swift
//  Planti
//
//  Created by Dominik Wieners on 18.11.20.
//

import SwiftUI


extension View {
    
    func cardContained(background: Color = Color.secondarySystemBackground, cornerRadius: CGFloat = 8) -> some View {
        self
        .padding(.all)
        .background(background)
        .cornerRadius(cornerRadius)
    }
}
