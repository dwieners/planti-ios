//
//  AuthViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 04.12.20.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuth = false
    @Published var isLoading = false
    
  
    
    func login(){
        var seconds = 1
        isLoading = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            seconds -= 1
            if seconds == 0 {
                self.isLoading = false
                self.isAuth = true
                timer.invalidate()
            } else {
                print(seconds)
            }
        }
     
    }
}
