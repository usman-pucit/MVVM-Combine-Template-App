//
//  PhotosViewModel.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//  
//

import Combine
import Foundation

protocol PhotosViewModelType {
    func requestPhotos()
}

/// define all states of view.
enum PhotosViewModelState {
    case show([PhotoRowViewModel])
    case error(String)
}

class PhotosViewModel {
    
    @Published var isLoading = false
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK: - Private Properties
    
    private var cancellables: [AnyCancellable] = []
    private let useCase: PhotosUseCaseType
    private let stateDidUpdateSubject = PassthroughSubject<PhotosViewModelState, Never>()

    // MARK: Initializer

    init(useCase: PhotosUseCaseType) {
        self.useCase = useCase
    }
}

extension PhotosViewModel: PhotosViewModelType {
   
    func requestPhotos(){
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        isLoading = true
        let request = Request.photosRequest()
        useCase.request(request)
            .sink { [weak self] result in
                guard let `self` = self else { return }
                self.isLoading = false
                switch result {
                case .success(let photos):
                    let photoRows = photos.map(self.makePhotoRowViewModel(with:))
                    self.stateDidUpdateSubject.send(.show(photoRows))
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
    }
    
}

extension PhotosViewModel{
    
    private func makePhotoRowViewModel(with photoObject: PhotosModel)-> PhotoRowViewModel{
        return .init(id: photoObject.id ?? 0, album: "Album# \(photoObject.albumId ?? 0)", titleInfo: photoObject.title ?? "" , imageURL: photoObject.url ?? "", thumbnailUrl: photoObject.thumbnailUrl ?? "")
    }
}
