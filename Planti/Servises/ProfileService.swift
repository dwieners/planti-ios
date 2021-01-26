//
//  ProfileService.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation
import SwiftKeychainWrapper

class ProfileService {
    
    static var shared = ProfileService()
    
    
    /// Put Score
    /// - Parameter completion: PlantItem
    func getDailyScore(completion: @escaping (Result<StandardResponseMessage,Error>)->Void,
                      urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        let endpoint = Endpoint.profileMeScore
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "PUT"
        
        
        let accessToken = KeychainWrapper.standard.string(forKey: "token")
        debugPrint("[ACCESS TOKEN] \(accessToken!)")
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request){ (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                guard let data = data else { return }
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
                let standardResponse = try JSONDecoder().decode(StandardResponseMessage.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(standardResponse))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
}

