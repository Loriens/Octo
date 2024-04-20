//
//  Reusable.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
