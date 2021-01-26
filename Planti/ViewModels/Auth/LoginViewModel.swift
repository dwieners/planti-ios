//
//  LoginViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 19.01.21.
//

import Foundation
import SwiftKeychainWrapper

enum LoginAlerts: Identifiable {
    var id: Int {
        self.hashValue
    }
    case emptyUsernameOrPassword;
    case shortPasswort;
    case userDosentExist;
    case wrongPassword;
}




class LoginViewModel: ObservableObject {
    
    @Published var token: String?
    @Published var isLoading: Bool = false
    @Published var loginAlerts: LoginAlerts?
    
    
    func isValidLogin(username: String, password: String)->Bool{
        if username == "" || password == "" {
            loginAlerts = .emptyUsernameOrPassword
            return false
        }
        return true
    }
    
    func checkResponseCode(code: Int){
        switch code {
        case 401:
            loginAlerts = .wrongPassword
            break
        case 403:
            loginAlerts = .userDosentExist
            break
        default:
            loginAlerts = nil
        }
    }
    
    
    func login(username: String, password: String){
        if isValidLogin(username: username, password: password){
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
                self.checkResponseCode(code: response.statusCode)
                debugPrint("🌎[\(response.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode ))")
            }
        }
    }
    
}
