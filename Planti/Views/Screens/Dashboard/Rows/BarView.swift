//
//  BarView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

struct BarView: View {
    
    var value:CGFloat
    var foregroundColor: Color = .blue
    var barColor: Color = Color.black.opacity(0.2)
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Capsule() // no need for state var anymore
                .frame(width: geometry.size.width, height: geometry.size.height)
                .foregroundColor(barColor)
                
                
            }.frame(height: 20)
            
            GeometryReader { geometry in
                Capsule() // no need for state var anymore
                .frame(width: geometry.size.width * value, height: geometry.size.height)
                    .foregroundColor(foregroundColor)
                
            }.frame(height: 20)
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView( value: 0.7)
    }
}
