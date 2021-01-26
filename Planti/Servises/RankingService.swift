//
//  RankingService.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation
import SwiftKeychainWrapper


///
/// # UserItem
///
struct UserItem: Codable, Identifiable {
    let id: Int
    let public_id: String
    let username: String
    let score: Int
}


///
/// # UserRanking
///
struct UserRanking: Codable, Identifiable{
    let id: String
    let user: UserItem
    let is_current: Bool
}


class RankingService {
    
    static var shared = RankingService()
    
    /// Request overview of Planti Plants
    /// - Parameter completion: PlantItem
    func load_ranking(completion: @escaping (Result<[UserRanking],Error>)->Void,
                      urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        let endpoint = Endpoint.ranking
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
        
        let accessToken = KeychainWrapper.standard.string(forKey: "token")
        
        debugPrint("[ACCESS TOKEN] \(accessToken!)")
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( accessToken, forHTTPHeaderField: "Authorization")
        
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
                
                let ranking = try JSONDecoder().decode([UserRanking].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(ranking))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
}



