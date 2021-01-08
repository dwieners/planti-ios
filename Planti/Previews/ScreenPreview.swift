//
//  ScreenPreview.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

struct ScreenPreview<Screen: View>: View {
    var screen: Screen

    var body: some View {
        ForEach(values: deviceNames) { device in
            ForEach(values: ColorScheme.allCases) { scheme in
                NavigationView {
                    self.screen
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                .previewDevice(PreviewDevice(rawValue: device))
                .colorScheme(scheme)
                .previewDisplayName("\(scheme.previewName): \(device)")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }

    private var deviceNames: [String] {
        [
            "iPhone 8",
            "iPhone 11",
//            "iPhone 11 Pro Max",
//            "iPad (7th generation)",
//            "iPad Pro (12.9-inch) (4th generation)"
        ]
    }
}




extension View {
    func previewAsScreen() -> some View {
        ScreenPreview(screen: self)
    }
}
