//
//  Movie.swift
//  MediaProject
//
//  Created by 강석호 on 6/11/24.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let poster_path: String?
}
