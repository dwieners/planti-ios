//
//  URL + Extension.swift
//  Planti
//
//  Created by Dominik Wieners on 01.12.20.
//

import SwiftUI

enum Endpoint {
    //----------------------------
    case classify(model: Classifier)
    //-------------------------------
    case allPlants
    case overviewPlants
    case plants(key: String)
    case observation(key: String, latitude: Double, longitude: Double)
    //-------------------------------
    case register
    case login
    //-------------------------------
    case ranking
    //-------------------------------
    case profileMeScore
}

enum Classifier: String {
    case mobilenet = "mobilenet"
    case plantinet = "plantinet"
}

extension Endpoint {
    var url: URL {
        switch self {
        case .classify(let model):
            return .makeForEndpoint("classify/\(model)")
        case .allPlants:
            return .makeForEndpoint("plants/all")
        case .overviewPlants:
            return .makeForEndpoint("plants/overview")
        case .plants(let key):
            return .makeForEndpoint("plants/\(key)")
        case .observation(let key, let latitude, let longitude):
            return .makeForEndpoint("observation/create/\(key)?lat=\(latitude)&lng=\(longitude)")
        case .register:
            return .makeForEndpoint("auth/register")
        case .login:
            return .makeForEndpoint("auth/login")
        case .ranking:
            return .makeForEndpoint("ranking/all")
        case .profileMeScore:
            return .makeForEndpoint("profile/me/score")
        }
        
    }
}


private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "http://192.168.0.80:5000/api/\(endpoint)")!
    }
}
