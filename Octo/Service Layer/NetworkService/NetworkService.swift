//
//  NetworkService.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation
import Combine

protocol NetworkService {
    func getPublisher<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError>
}
