//
//  UITableView.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 08/02/2021.
//

import UIKit

extension UITableView {
    public func registerClass<T: UITableViewCell>(cellClass classes: T.Type...) {
        classes.forEach {
            register($0, forCellReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        
        return cell
    }
}
