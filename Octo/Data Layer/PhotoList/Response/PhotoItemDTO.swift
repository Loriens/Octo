//
//  PhotoItemDTO.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

struct PhotoItemDTO: Decodable {
    struct SourceDTO: Decodable {
        let original: String?
        let large: String?
        let medium: String?
        let small: String?
    }

    let id: Int
    let width: CGFloat
    let height: CGFloat
    let src: SourceDTO
    let alt: String
    let photographer: String?
}
