//
//  ProfileService.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation
import SwiftKeychainWrapper
import SwiftUI


class ProfileService {
    
    static var shared = ProfileService()
    
    
    /// Get Avatar
    /// - Parameters:
    ///   - completion: Response
    ///   - urlResponse: URL Response
    func loadAvatar(completion: @escaping (Result<MyAvatar,Error>)->Void,
                     urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        let endpoint = Endpoint.profileMe
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
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
                
                let avatarResponse = try JSONDecoder().decode(MyAvatar.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(avatarResponse))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
        }.resume()
    }
    
    
    func loadInventory(completion: @escaping (Result<[MyInventoryItem],Error>)->Void,
                    urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        let endpoint = Endpoint.profileMeInventory
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
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
                
                let inventoryResponse = try JSONDecoder().decode([MyInventoryItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(inventoryResponse))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
        }.resume()
    }
    
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
    
    
    
    func loadMissions(completion: @escaping (Result<MyMissions,Error>)->Void,
                      urlResponse: @escaping (HTTPURLResponse) -> Void) {
        
        let endpoint = Endpoint.profileMeMissions
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
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
                
                let myMissions = try JSONDecoder().decode(MyMissions.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(myMissions))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
        }.resume()
        
    }
    
    
    func activateMission(mission_id: Int,  completion: @escaping (Result<StandardResponseMessage,Error>)->Void,
                         urlResponse: @escaping (HTTPURLResponse) -> Void){
        let endpoint = Endpoint.profileMeMissionsActivate(id: mission_id)
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        
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
                
                let res = try JSONDecoder().decode(StandardResponseMessage.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
        }.resume()
        
        
    }
    
    
    func completeMissionTarget(){
        
    }
    
    func loadMissionStatus(mission_id: Int, completion: @escaping (Result<MyMissionInfoStatus,Error>)->Void,
                           urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        let endpoint = Endpoint.profileMeMission(id: mission_id)
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
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
                
                let myMissionInfo = try JSONDecoder().decode(MyMissionInfoStatus.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(myMissionInfo))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
        }.resume()
        
        
    }
    
}

