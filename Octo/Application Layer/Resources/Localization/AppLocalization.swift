//
//  AppLocalization.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

enum AppLocalization {
    enum General: String, Localizable {
        case ok = "OK"
        case save = "Save"
        case cancel = "Cancel"
        case close = "Close"
        case unknown = "Unknown"
        case loading = "Loading"
        case refresh = "Refresh"
        case tryAgain = "TryAgain"
        case error = "Error"
    }

    enum Error: String, Localizable {
        case invalidAuthorization = "InvalidAuthorizationError"
        case unknown = "UnknownError"
    }

    enum PhotoList: String, Localizable {
        case title = "PostListTitle"
    }
}
