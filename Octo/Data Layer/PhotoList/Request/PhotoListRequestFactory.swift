//
//  PhotoListRequestFactory.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

enum PhotoListRequestFactory {
    case list
    case nextList(url: URL)

    private var method: String {
        switch self {
        case .list, .nextList:
            return "GET"
        }
    }

    private var path: String {
        switch self {
        case .list:
            return "curated"
        case .nextList:
            return ""
        }
    }
    
    private var url: URL {
        switch self {
        case .list:
            let url = URL(string: AppConfiguration.serverUrl) ?? URL(fileURLWithPath: "")
            return url.appendingPathComponent(path)
        case let .nextList(url):
            return url
        }
    }

    func makeRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 10
        return request
    }
}
