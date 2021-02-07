//
//  PhotosRequest.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//

import Foundation

extension Request{
    static func photosRequest() -> Request {
        let baseUrl = URL(string: "https://jsonplaceholder.typicode.com/")!
        let url = baseUrl.appendingPathComponent("photos")
        return Request(url: url, parameters: [:])
    }
}
