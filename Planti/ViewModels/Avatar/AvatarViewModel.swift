//
//  AvatarViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 28.01.21.
//

import SwiftUI


class AvatarViewModel: ObservableObject {
    
    @Published var myAvatar:MyAvatar?
    @Published var isLoading = false
    
    
    func loadAvatar() {
        self.isLoading = true
        ProfileService.shared.loadAvatar { res in
            switch res {
            case .success(let avatar):
                self.myAvatar = avatar
                debugPrint(avatar)
                self.isLoading = false
            case .failure(let error):
                debugPrint(error)
                self.isLoading = false
            }
        } urlResponse: { urlResponse in
            debugPrint("🌎[\(urlResponse.statusCode) Status] \(HTTPURLResponse.localizedString(forStatusCode: urlResponse.statusCode ))")
        }
    }

    
    
}
