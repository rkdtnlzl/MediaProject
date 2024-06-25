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
        let url = "\(APIURL.tmdbRootUrl)movie/\(movieID)/similar"
        let params: [String: Any] = ["api_key": APIKey.mediaKey]
        
        AF.request(url, parameters: params).responseDecodable(of: Movie.self) { response in
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
        let url = "\(APIURL.tmdbRootUrl)movie/\(movieID)/recommendations"
        let params: [String: Any] = ["api_key": APIKey.mediaKey]
        
        AF.request(url, parameters: params).responseDecodable(of: Movie.self) { response in
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
        let url = "\(APIURL.tmdbRootUrl)movie/\(movieID)/images"
        let params: [String: Any] = ["api_key": APIKey.mediaKey]
        
        AF.request(url, parameters: params).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                print("성공")
                dump(value.posters)
                completionHandler(value.posters)
            case .failure(let error):
                print("실패")
                print(error)
            }
        }
    }
}
