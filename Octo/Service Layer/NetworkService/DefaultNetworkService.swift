//
//  DefaultNetworkService.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation
import Combine

final class DefaultNetworkService: NetworkService {
    private static let decoder = JSONDecoder()
    private let session: URLSession
    private let retryCount: Int
    private let queue: DispatchQueue

    init(
        session: URLSession = .shared,
        retryCount: Int = 0,
        queue: DispatchQueue = DispatchQueue(label: "default.network.client")
    ) {
        self.session = session
        self.retryCount = retryCount
        self.queue = queue
    }

    func getPublisher<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
        var request = request
        request.setValue(AppConfiguration.apiKey, forHTTPHeaderField: "Authorization")

        return session
            .dataTaskPublisher(for: request)
            .subscribe(on: queue)
            .retry(retryCount)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        throw NetworkError.invalidAuthorization
                    } else {
                        throw NetworkError.invalidStatusCode(response.statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: Self.decoder)
            .mapError { error -> NetworkError in
                switch error {
                case let error as NetworkError:
                    return error
                case let error as DecodingError:
                    return .decoding(error)
                default:
                    return .unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
