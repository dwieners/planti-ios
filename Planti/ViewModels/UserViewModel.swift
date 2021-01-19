//
//  UserViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import Foundation
import SwiftUI

struct User {
    var username: String
    var password: String
}


class UserViewModel: ObservableObject {
    
    @Published var user: User = User(username: "", password: "")
    
}
