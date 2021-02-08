//
//  UIView+Reusable.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 08/02/2021.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}
