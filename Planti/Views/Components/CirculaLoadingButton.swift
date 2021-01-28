//
//  CirculaLoadingButton.swift
//  Planti
//
//  Created by Dominik Wieners on 27.01.21.
//

import SwiftUI

struct CirculaLoadingButton: View {
    
    var action: () -> Void
    
    @Binding var isLoading: Bool
    
    @State private var isSpinning: Bool = false

    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    
    var body: some View {
        Button(action: action ){
            if isLoading {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: isSpinning ? 360.0 : 0))
                    .animation(foreverAnimation)
                    .onDisappear(perform: {
                        self.isSpinning.toggle()
                    })
                    .onAppear(perform: {
                        self.isSpinning.toggle()
                    })
            } else {
                Image(systemName: "arrow.right")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .foregroundColor(.white)
            }
        }
        .padding(16)
        .background( Color.green)
        .mask(Capsule())
    }
    
}

struct CirculaLoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        CirculaLoadingButton(action: {}, isLoading: .constant(true))
    }
}
