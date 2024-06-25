//
//  Poster.swift
//  MediaProject
//
//  Created by 강석호 on 6/25/24.
//

import Foundation

struct Poster: Decodable {
    let posters: [PosterResponse]
}

struct PosterResponse: Decodable {
    let file_path: String?
}
