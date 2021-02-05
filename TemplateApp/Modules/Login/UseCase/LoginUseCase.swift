//
//  LoginUseCase.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 06/02/2021.
//  
//

import Combine
import Foundation

protocol LoginUseCaseType {
    func request<T: Decodable>(_ request: Request<T>) -> AnyPublisher<Result<T, APIError>, Never>
}

class LoginUseCase {
    // MARK: -  Properties

    var apiClient: APIClientType

    // MARK: - Initializer

    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - Extension

extension LoginUseCase: LoginUseCaseType {
    func request<T: Decodable>(_ request: Request<T>) -> AnyPublisher<Result<T, APIError>, Never> {
        return apiClient
            .execute(request)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
