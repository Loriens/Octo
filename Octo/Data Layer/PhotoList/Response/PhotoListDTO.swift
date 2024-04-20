//
//  PhotoListDTO.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Foundation

struct PhotoListDTO: Decodable {
    let page: Int?
    let per_page: Int?
    let photos: [PhotoItemDTO?]?
    let next_page: String?
}
