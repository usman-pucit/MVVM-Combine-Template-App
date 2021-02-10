//
//  APIClient.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//  
//

import Combine
import Foundation

enum APIError: Error {
    case networkError
    case unknown(String)
}

protocol APIClientType{
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable
}

class APIClient: APIClientType{
    // MARK: - Function
    
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T : Decodable {
        guard let request = request.request else {
            return .just(.failure(.networkError))
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .map {.success($0)}
        .catch ({ error -> AnyPublisher<Result<T, APIError>, Never> in
            return .just(.failure(APIError.unknown(error.localizedDescription)))
        })
        .eraseToAnyPublisher()
    }
}
