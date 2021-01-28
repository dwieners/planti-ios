//
//  SelectionViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 17.01.21.
//

import Foundation
import SwiftUI
import CoreLocation

enum Tab {
    case flower
    case leaf
}


enum SelectionSheet: Identifiable {
    var id: Int {
        self.hashValue
    }
    case camera
    case picker
    case invalid
}


enum SelectionAlert: Identifiable {
    var id: Int {
        self.hashValue
    }
    case emptyImage
}
class SelectionViewModel: ObservableObject {
    @Published var plantShape: PlantShape?
    @Published var selection: Tab = .flower
    @Published var selectionSheet: SelectionSheet?
    @Published var selectionAlerts: SelectionAlert?
    @Published var flowerImage: UIImage?
    @Published var location: CLLocation?
}
