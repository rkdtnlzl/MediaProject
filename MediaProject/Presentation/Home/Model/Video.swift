//
//  Video.swift
//  MediaProject
//
//  Created by 강석호 on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let results: [VideoResponse]
}

struct VideoResponse: Decodable {
    let key: String?
    let site: String?
}
