//
//  LoginRequest.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 06/02/2021.
//

import Foundation

extension Request{
    static func login(email: String, password: String) -> Request<LoginModel> {
        let url = URL(string: "https://www.placeholder.com/api/"+"login/")!
        let parameters: [String : CustomStringConvertible] = [
            "email": email,
            "password": password
            ]
        return Request<LoginModel>(url: url, parameters: parameters)
    }
}
