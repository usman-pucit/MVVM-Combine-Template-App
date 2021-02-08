//
//  PhotoRowViewModel.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 08/02/2021.
//

import Foundation

struct PhotoRowViewModel {
    let id: Int
    let album: String
    let titleInfo: String
    let imageURL: String
    let thumbnailUrl: String
}

extension PhotoRowViewModel: Hashable {
    static func == (lhs: PhotoRowViewModel, rhs: PhotoRowViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
