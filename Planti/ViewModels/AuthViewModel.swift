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
   
    
   
    
//    func login(){
//        var seconds = 1
//        isLoading = true
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            seconds -= 1
//            if seconds == 0 {
//                self.isLoading = false
//                self.isAuth = true
//                timer.invalidate()
//            } else {
//                print(seconds)
//            }
//        }
//
//    }
}
