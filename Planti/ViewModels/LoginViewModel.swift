//
//  LoginViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 19.01.21.
//

import Foundation
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
    
    @Published var token: String?
    @Published var isLoading: Bool = false
    
    func login(username: String, password: String){
        self.isLoading = true
        AuthService.shared.login(username: username, password: password) { res in
            switch (res){
            case .success(let auth):
                debugPrint("🔑 [Token] \(auth.token)")
                self.token = auth.token
                KeychainWrapper.standard.set(auth.token, forKey: "token")
                self.isLoading = false
            case .failure(let error):
                debugPrint("🤬 [Error] \(error.localizedDescription)")
                self.isLoading = false
            }
        } urlResponse: { response in
            debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
        }
    }
    
}
