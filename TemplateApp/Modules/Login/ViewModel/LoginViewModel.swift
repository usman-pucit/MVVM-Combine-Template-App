//
//  LoginViewModel.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 06/02/2021.
//  
//

import Combine
import Foundation

protocol LoginViewModelType {
    func request(_ request: Request<LoginModel>)
}

/// define all states of view.
enum LoginViewModelState {
    case show([LoginModel])
    case error(String)
}

class LoginViewModel {
    
    @Published var isLoading = false
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK: - Private Properties
    
    private var cancellables: [AnyCancellable] = []
    private let useCase: LoginUseCaseType
    private let stateDidUpdateSubject = PassthroughSubject<LoginViewModelState, Never>()

    // MARK: Initializer

    init(useCase: LoginUseCaseType) {
        self.useCase = useCase
    }
}

extension LoginViewModel: LoginViewModelType {
   
    func request(_ request: Request<LoginModel>){
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        isLoading = true
        useCase.request(request)
            .sink { [weak self] result in
                guard let `self` = self else { return }
                self.isLoading = false
                switch result {
                case .success(let value):
                    self.stateDidUpdateSubject.send(.show([value]))
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
    }
    
}
