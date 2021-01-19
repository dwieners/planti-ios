//
//  RegistrationViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 19.01.21.
//

import Foundation
import SwiftKeychainWrapper

enum RegistrationAlerts: Identifiable {
    var id: Int {
        self.hashValue
    }
    case emptyUsernameOrPassword;
    case shortPasswort;
    case userAlreadyExist;
}


class RegistrationViewModel: ObservableObject {
    
    
    @Published var token: String?
    @Published var isLoading = false
    @Published var registrationSheet: RegistrationAlerts?
    
    
    func isValidLogin(username: String, password: String)->Bool{
        if username == "" || password == "" {
            registrationSheet = .emptyUsernameOrPassword
            return false
        }
        return true
    }
    
    func checkResponseCode(code: Int){
        if code == 403 {
            registrationSheet = .userAlreadyExist
        }
    }
    
    func register(username: String, password: String){
        if isValidLogin(username: username, password: password){
            self.isLoading = true
            AuthService.shared.register(username: username, password: password){ res in
                switch (res){
                case .success(let auth):
                    print(auth)
                    debugPrint("🔑 [Token] \(auth.token)")
                    self.token = auth.token
                    KeychainWrapper.standard.set(auth.token, forKey: "token")
                    self.isLoading = false
                case .failure(let error):
                    debugPrint("🤬 [Error] \(error.localizedDescription)")
                    self.isLoading = false
                }
                
            } urlResponse: { response in
                self.checkResponseCode(code: response.statusCode)
                debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
            }
        }
    }
}
