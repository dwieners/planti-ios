//
//  ContentSizeCategory.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

/**
 https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/
 */

extension ContentSizeCategory {
    static let smallestAndLargest = [allCases.first!, allCases.last!]
    
    var previewName: String {
        self == Self.smallestAndLargest.first ? "Small" : "Large"
    }
}
