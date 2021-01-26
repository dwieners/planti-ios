//
//  ObservationService.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

struct StandardResponseMessage: Codable {
    let message: String
}


class ObservationService {
    
    static var shared = ObservationService()
    
    
    
    /// Classify Image
    /// - Parameters:
    ///   - image: UIImage
    ///   - completion: PlantPredictionResult
    func observation(with image: UIImage, key: String, latitude: Double, longitude: Double,
                     completion: @escaping (Result<StandardResponseMessage, Error>) -> Void){
        
        // Set image for endpoint
        guard let mediaImage = Media(withImage: image, for: "img") else {return }
        
        //endpoint
        let endpoint = Endpoint.observation(key: key, latitude: latitude, longitude: longitude)
        
        // Set request
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        // Get accessToken
        let accessToken = KeychainWrapper.standard.string(forKey: "token")
        debugPrint("[ACCESS TOKEN] \(accessToken!)")
        
        // Set Headers
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue( accessToken, forHTTPHeaderField: "Authorization")
        
        
        let dataBody = createDataBody(withParameters:nil, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
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
    
    
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}
