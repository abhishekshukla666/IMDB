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
    case topRated(page: String)
    case details(id: Int)
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
        case .topRated:
            return "3/movie/top_rated"
        case .details(let id):
            return "3/movie/\(id)"
        }
        
    }

    fileprivate func willPrepareQueryItems(_ page: String) -> [URLQueryItem]? {
        var queryItems: [URLQueryItem] = .init()
        queryItems.append(.init(name: "language", value: "en-US"))
        queryItems.append(.init(name: "api_key", value: "f1903be2b881067835c39fa6f8990a95"))
        if !page.isEmpty {
            queryItems.append(URLQueryItem(name: "page", value: page))
            
        }
        return queryItems
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .nowPlaying(page: let page):
            return willPrepareQueryItems(page)
        case .popular(let page):
            return willPrepareQueryItems(page)
        case .upcoming(let page):
            return willPrepareQueryItems(page)
        case .topRated(page: let page):
            return willPrepareQueryItems(page)
        case .details:
            return willPrepareQueryItems("")
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
