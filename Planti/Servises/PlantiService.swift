//
//  PlantiService.swift
//  Planti
//
//  Created by Dominik Wieners on 10.12.20.
//

import Foundation
import UIKit


struct PlantInfo: Decodable{
    let title: String
    let description: String
}


struct PlantPrediction: Decodable {
    let label: String
    let prediction: String
}

struct PlantPredicationResult: Decodable {
    let predictions: [PlantPrediction]
    let success: Bool
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



class PlantiService {
    
    static let shared = PlantiService()
    
    
    
    /// Request Infos by label of CNN
    /// - Parameters:
    ///   - label: String
    ///   - completion: PlantInfo
    func info(label: String, completion: @escaping (Result<PlantInfo, Error>) -> Void){
        
        print("Begginnninggnn")
        
        let endpoint = Endpoint.info(label: label)
        
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
    
    
    
    /// Classify Image
    /// - Parameters:
    ///   - image: UIImage
    ///   - completion: PlantPredictionResult
    func classify(withImage image: UIImage, completion: @escaping (Result<PlantPredicationResult, Error>) -> Void){
        
        guard let mediaImage = Media(withImage: image, for: "img") else {return }
        
        let endpoint = Endpoint.classify
        
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
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
                let prediction = try JSONDecoder().decode(PlantPredicationResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(prediction))
                }
                
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(.failure(jsonError))
                }
            }
            //            if let resonse = response {
            //                print(resonse)
            //            }
            //
            //            if let data = data {
            //                do {
            //                    let json = try JSONSerialization.jsonObject(with: data, options: [])
            //                    print(json)
            //                } catch {
        }.resume()
    }
    
    
    
    func loadData(){
        print("Hallo")
        guard let url = URL(string: "http://192.168.0.80:5000/") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json)
                    }
                }catch let error as NSError {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
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
