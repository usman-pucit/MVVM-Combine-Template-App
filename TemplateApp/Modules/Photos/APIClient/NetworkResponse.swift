//
//  NetworkResponse.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 05/02/2021.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: [Wrapped]
}
