//
//  APIManager.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import Foundation

// MARK: - Network

class Network: NSObject {
    
    // MARK: - Network Error
    
    enum NetworkError: Error {
        case invalidURL
        case parseError
        case requestError
        case noJSONData
        case unknown
    }
    
    enum Headers {
        case contentType
        
        var value: [String : String] {
            switch self {
            case .contentType:
                return ["Content-type": "application/json"]
            }
        }
    }
    
    var headers: [Network.Headers] = [Headers.contentType]
    
    // MARK: - Properties
    
    var apiUrl: URL?
    
    // MARK: - Initialization
    
    init(api: URL?) {
        apiUrl = api
    }
    
    // MARK: - Class Methods
    
    func get<T: Decodable>(endpoint: String, completion: @escaping ((Result<T, Network.NetworkError>) -> Void)) {
        
        guard let url = apiUrl else { completion(.failure(NetworkError.invalidURL)); return }
        
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
                completion(.failure(NetworkError.unknown))
                
            case .success(let response, let data):
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(NetworkError.noJSONData))
                }
                
                let decoder = JSONDecoder()
                
                switch httpResponse.statusCode {
                case 200...299:
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(NetworkError.parseError))
                    }
                case 400...499:
                    completion(.failure(NetworkError.unknown))
                default:
                    completion(.failure(NetworkError.unknown))
                }
            }
        }.resume()
    }
}

extension URLSession {
    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
