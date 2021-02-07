//
//  PhotosViewController.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//  
//

import UIKit
import Combine

class PhotosViewController: UIViewController {

    // MARK: Properties

    private var viewModel: PhotosViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotosViewModel(useCase: PhotosUseCase())
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [unowned self] state in
            // Todo ...
        }).store(in: &cancellable)
    }
}
