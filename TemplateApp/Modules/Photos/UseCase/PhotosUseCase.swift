//
//  PhotosUseCase.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//  
//

import Combine
import Foundation

protocol PhotosUseCaseType {
    func request(_ request: Request) -> AnyPublisher<Result<PhotosModel, APIError>, Never>
}

class PhotosUseCase {
    // MARK: -  Properties

    var apiClient: APIClientType

    // MARK: - Initializer

    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - Extension

extension PhotosUseCase: PhotosUseCaseType {
    func request(_ request: Request) -> AnyPublisher<Result<PhotosModel, APIError>, Never> {
        return apiClient
            .execute(request)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
