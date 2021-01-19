//
//  SelectionViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 17.01.21.
//

import Foundation
import SwiftUI

class SelectionViewModel: ObservableObject {
    
    @Published var plantShape: PlantShape?
    @Published var selection: Tab = .flower
    @Published var imageSheet: Sheet?
    @Published var flowerImage: UIImage?
    
}