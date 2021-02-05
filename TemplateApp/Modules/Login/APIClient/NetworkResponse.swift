//
//  NetworkResponse.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 05/02/2021.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var responseCode: Int?
    var responseMessage: String?
    var result: Wrapped?
    
    // MARK: - Model Keys
    enum CodingKeys: String, CodingKey{
        case responseCode
        case responseMessage
        case result
    }
    
    // MARK: - Model mapping
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        result = try values.decodeIfPresent(Wrapped.self, forKey: .result)
    }
}
