//
//  ForEach.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
