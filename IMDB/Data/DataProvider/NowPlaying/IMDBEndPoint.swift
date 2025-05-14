//
//  IMDBEndPoint.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

enum IMDBEndPoint {
    case nowPlaying(page: String)
    case popular(page: String)
    case upcoming(page: String)
}

extension IMDBEndPoint: EndPoint {
    var host: String {
        return "https://api.themoviedb.org/"
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "3/movie/now_playing"
        case .popular:
            return "3/movie/popular"
        case .upcoming:
            return "3/movie/upcoming"
        }
        
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .nowPlaying(page: let page):
            return [
                .init(name: "language", value: "en-US"),
                .init(name: "page", value: page),
                .init(name: "api_key", value: "f1903be2b881067835c39fa6f8990a95")
            ]
        case .popular(let page):
            return [
                .init(name: "language", value: "en-US"),
                .init(name: "page", value: page),
                .init(name: "api_key", value: "f1903be2b881067835c39fa6f8990a95")
            ]
        case .upcoming(let page):
            return [
                .init(name: "language", value: "en-US"),
                .init(name: "page", value: page),
                .init(name: "api_key", value: "f1903be2b881067835c39fa6f8990a95")
            ]
        }
    }
    
    var method: String {
        return NetworkMethod.get.rawValue
    }
    
    var headers: [String : String]? {
        let authorizationHeader = "Bearer \(accessToken)"
        return ["Authorization": authorizationHeader]
    }
    
    var body: BodyType? { return nil }
    
}
