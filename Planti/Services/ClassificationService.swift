//
//  ClassificationService.swift
//  Planti
//
//  Created by Dominik Wieners on 10.12.20.
//

import Foundation
import UIKit



///
/// # Predictions
///
struct PlantPrediction: Codable, Identifiable{
    let id: String
    let item: PlantItem
    let prediction: Double
}

struct PlantPredicationResult: Codable {
    let predictions: [PlantPrediction]
}


struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, for key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpeg"
        
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return nil
        }
        self.data = data
    }
}

typealias Parameters = [String: String]



class ClassificationService {
    
    static let shared = ClassificationService()
    
    
    
    
    /// Classify Image
    /// - Parameters:
    ///   - image: UIImage
    ///   - completion: PlantPredictionResult
    func classify(with image: UIImage, completion: @escaping (Result<PlantPredicationResult, Error>) -> Void){
        
        guard let mediaImage = Media(withImage: image, for: "img") else {return }
        
        let endpoint = Endpoint.classify(model: .plantinet)
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
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
                
                let prediction = try JSONDecoder().decode(PlantPredicationResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(prediction))
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
