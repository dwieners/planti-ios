//
//  AuthViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 04.12.20.
//

import SwiftUI
import SwiftKeychainWrapper

class AuthViewModel: ObservableObject {
    
    @Published var token: String?
    
    func resetAuth(){
        token = nil
        KeychainWrapper.standard.removeAllKeys()
    }
    
}

