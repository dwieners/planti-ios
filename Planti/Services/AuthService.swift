//
//  AuthService.swift
//  Planti
//
//  Created by Dominik Wieners on 18.01.21.
//

import Foundation


struct AuthResponse: Codable {
    let token: String
}

enum FigureType: String, CaseIterable, Codable {
    var id: Int {
        self.hashValue
    }
    case WITCH = "WITCH";
    case WIZARD = "WIZARD"
}

class AuthService {
    
    
    static let shared = AuthService()
    
    func register(username: String, password: String, figure_type: FigureType,
                  completion: @escaping (Result<AuthResponse,Error>)->Void,
                  urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        // create body
        let json = ["username": username, "password": password, "figure_type": figure_type.rawValue]
        
        // create the endpoint url
        let endpoint = Endpoint.register
        
        // create session object
        let session = URLSession.shared
        
        // creating request object
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch(let error){
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // using session object to send data to the server
        session.dataTask(with: request){ (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    urlResponse(response)
                }
            }
            
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
                
                let info = try JSONDecoder().decode(AuthResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(info))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    
    func login(username: String, password: String, completion: @escaping (Result<AuthResponse,Error>)->Void, urlResponse: @escaping (HTTPURLResponse) -> Void){
        
        // create body
        let json = ["username": username, "password": password]
        
        // create the endpoint url
        let endpoint = Endpoint.login
        
        // create session object
        let session = URLSession.shared
        
        // creating request object
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch(let error){
            debugPrint("🤬 [Error] \(error.localizedDescription)")
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // using session object to send data to the server
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
                debugPrint("👨‍💻 [JSON] \(json)")
                
                let info = try JSONDecoder().decode(AuthResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(info))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            
            if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    urlResponse(response)
                }
            }
            
        }.resume()
    }
    
}
