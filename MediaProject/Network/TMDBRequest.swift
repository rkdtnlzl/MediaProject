//
//  TMDBRequest.swift
//  MediaProject
//
//  Created by 강석호 on 6/26/24.
//

import UIKit
import Alamofire

enum TMDBRequest {
    case similarMovies(movieID: Int)
    case recommendedMovies(movieID: Int)
    case movieImages(movieID: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: String {
        switch self {
        case .similarMovies(let movieID):
            return "\(baseURL)movie/\(movieID)/similar"
        case .recommendedMovies(let movieID):
            return "\(baseURL)movie/\(movieID)/recommendations"
        case .movieImages(let movieID):
            return "\(baseURL)movie/\(movieID)/images"
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": APIKey.mediaAccessToken,
            "accept": "application/json"
        ]
    }
    
    var parameters: Parameters {
        return ["api_key": APIKey.mediaKey]
    }
}
