//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by 강석호 on 6/25/24.
//

import UIKit
import Alamofire

class TMDBAPI {
    
    static let shared = TMDBAPI()
    
    private init() { }
    
    func fetchSimilarMovies(movieID: Int, completionHandler: @escaping ([MovieResponse]) -> Void) {
        let request = TMDBRequest.similarMovies(movieID: movieID)
        
        AF.request(request.endpoint, parameters: request.parameters, headers: request.headers).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                dump(value.results)
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRecommendedMovies(movieID: Int, completionHandler: @escaping ([MovieResponse]) -> Void) {
        let request = TMDBRequest.recommendedMovies(movieID: movieID)
        
        AF.request(request.endpoint, parameters: request.parameters, headers: request.headers).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                dump(value.results)
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPosterMovies(movieID: Int, completionHandler: @escaping ([PosterResponse]) -> Void) {
        let request = TMDBRequest.movieImages(movieID: movieID)
        
        AF.request(request.endpoint, parameters: request.parameters, headers: request.headers).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                print("성공")
                dump(value.posters)
                completionHandler(value.posters)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTrendingMovies(completionHandler: @escaping ([Media]) -> Void) {
        let request = TMDBRequest.trendingMovies
        
        AF.request(request.endpoint, parameters: request.parameters, headers: request.headers).responseDecodable(of: MediaResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
