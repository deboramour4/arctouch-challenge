//
//  APIManager.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

class Network {
    
    // MARK: - Error cases
    enum RequestError: Error {
        case invalidURL
        case parseError
        case requestError
        case noJSONData
        case unknown
    }
    
    // MARK: - Request header types
    enum Headers {
        case contentType
        
        var value: [String : String] {
            switch self {
            case .contentType:
                return ["Content-type": "application/json"]
            }
        }
    }
    
    // MARK: - Properties
    public var headers: [Network.Headers] = [Headers.contentType]
    private var apiUrl: URL?
    
    // MARK: - Initializer
    init(api: URL?) {
        apiUrl = api
    }
    
    // MARK: - HTTP Methods
    func get<T: Decodable>(endpoint: String, completion: @escaping ((Result<T, Network.RequestError>) -> Void)) {
        
        guard let url = apiUrl else { completion(.failure(RequestError.invalidURL)); return }
        
        let newUrl = url.appendingPathComponent(endpoint)

        var request = URLRequest(url: newUrl)
        
        headers.forEach { (header) in
            header.value.forEach { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { (result) in
            
            switch result {
            case .failure(_):
                completion(.failure(RequestError.unknown))
                
            case .success(let response, let data):
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(RequestError.noJSONData))
                }
                
                let decoder = JSONDecoder()
                
                switch httpResponse.statusCode {
                case 200...299:
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(RequestError.parseError))
                    }
                case 400...499:
                    completion(.failure(RequestError.unknown))
                default:
                    completion(.failure(RequestError.unknown))
                }
            }
        }.resume()
    }
}
