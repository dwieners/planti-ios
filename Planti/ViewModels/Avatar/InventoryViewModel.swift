//
//  InventoryViewModel.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import Foundation


class InventoryViewModel : ObservableObject {
    @Published var invetoryItems = [MyInventoryItem]()
    @Published var isLoading = false
    
    func loadInventory() {
        self.isLoading = true
        ProfileService.shared.loadInventory { res in
            switch res {
            case .success(let inventory):
                self.invetoryItems = inventory
                debugPrint(inventory)
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
