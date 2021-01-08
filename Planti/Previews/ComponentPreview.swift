//
//  ComponentPreview.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

struct ComponentPreview<Component: View>: View {
    var component: Component

    var body: some View {
        ForEach(values: ColorScheme.allCases) { scheme in
            ForEach(values: ContentSizeCategory.smallestAndLargest) { category in
                self.component
                    .previewLayout(.sizeThatFits)
                    .background(Color(UIColor.systemBackground))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, category)
                    .previewDisplayName(
                        "\(scheme.previewName) + \(category.previewName)"
                    )
            }
        }
    }
}


extension View {
    func previewAsComponent() -> some View {
        ComponentPreview(component: self)
    }
}
