//
//  Button + Extension.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI


struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(Font.body.bold())
            .padding(10)
            .padding(.horizontal, 20)
            .background(Color.green)
            .cornerRadius(5)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(.easeInOut(duration: 0.3))
       
    }
}
extension Button {
    func withActionButtonStyles() -> some View {
        self.foregroundColor(.white)
            .font(Font.body.bold())
            .padding(10)
            .padding(.horizontal, 20)
            .background(Color.blue)
            .cornerRadius(5)
    }
}
