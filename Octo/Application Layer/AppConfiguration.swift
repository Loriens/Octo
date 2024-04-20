//
//  AppConfiguration.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

enum AppConfiguration {
    static var serverUrl: String {
        let serverUrl = Bundle.main.infoDictionary?["ServerUrl"] as? String
        return serverUrl ?? ""
    }

    /// Get Pexels API key at https://www.pexels.com/api/
    static var apiKey = "YOUR_API_KEY"
}
