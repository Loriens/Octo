//
//  Localizable.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

protocol Localizable: RawRepresentable { }

extension Localizable {
    var key: String {
        return rawValue as? String ?? ""
    }

    var localized: String {
        return NSLocalizedString(key, comment: "")
    }
}
