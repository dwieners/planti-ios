//
//  PlantService.swift
//  Planti
//
//  Created by Dominik Wieners on 13.01.21.
//

import Foundation

///
///# PlantItem
///
struct PlantItem: Codable, Identifiable {
    let id: Int
    let key: String
    let title: String
    let scientific_name: String
    let image: String

}

///
///# PlantInfo
///
struct PlantInfo: Codable, Identifiable{
    let id: Int
    let title: String
    let image: String
    let scientific_name: String
    let taxonomy: String
    let description: String
}


class PlantService {
    
    static let shared = PlantService()
    
    
    /// Request overview of Planti Plants
    /// - Parameter completion: PlantItem
    func overview(completion: @escaping (Result<[PlantItem], Error>) -> Void) {
        
        let endpoint = Endpoint.overviewPlants
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
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
                
                let overview = try JSONDecoder().decode([PlantItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(overview))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    
    
    /// Request Infos by label of CNN
    /// - Parameters:
    ///   - label: String
    ///   - completion: PlantInfo
    func details(
        key: String,
        completion: @escaping (Result<PlantInfo, Error>) -> Void,
        urlResponse: @escaping (HTTPURLResponse) -> Void?){
        
        let endpoint = Endpoint.plants(key: key)
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
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
                
                let info = try JSONDecoder().decode(PlantInfo.self, from: data)
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
    
    
}
