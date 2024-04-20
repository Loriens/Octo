//
//  NetworkError.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidAuthorization
    case invalidStatusCode(_ statusCode: Int)
    case decoding(_ error: DecodingError)
    case unknown(_ error: Error)
}
