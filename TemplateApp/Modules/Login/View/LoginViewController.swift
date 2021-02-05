//
//  LoginViewController.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 06/02/2021.
//  
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    // MARK: Properties

    private var viewModel: LoginViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(useCase: LoginUseCase())
        bindViewModel()
    }
    
    private func bindViewModel() {
//         Network Request example
//         viewModel.request(Request<LoginModel>.login(email: "", password: ""))
        
//        Binding ViewModel
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            // Todo ...
        }).store(in: &cancellable)
    }
}
