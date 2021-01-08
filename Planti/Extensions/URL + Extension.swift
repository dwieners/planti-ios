//
//  URL + Extension.swift
//  Planti
//
//  Created by Dominik Wieners on 01.12.20.
//

import SwiftUI

enum Endpoint {
    case classify
    case info(label: String)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .classify:
            return .makeForEndpoint("classify")
        case .info(let label):
            return .makeForEndpoint("info/\(label)")
        }
    
    }
}


private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "http://192.168.0.80:5000/\(endpoint)")!
    }
}
