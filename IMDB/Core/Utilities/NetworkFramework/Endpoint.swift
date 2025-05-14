
//
//  Untitled.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

public typealias BodyType = Any

let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMTkwM2JlMmI4ODEwNjc4MzVjMzlmYTZmODk5MGE5NSIsIm5iZiI6MTc0NjI2NDE0OC42OTgsInN1YiI6IjY4MTVlMDU0YzM0ZDE4Y2FlYzkxMmU3YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.I3S7yVP4rGi9bmCuUheVvpxa5bpq0_W6_BhqkdiG0yI"

public protocol EndPoint {
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: BodyType? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndPoint {
    var urlRequest: URLRequest? {
        let urlString = "\(host)\(path)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)

        /// Configure the HTTP method.
        request.httpMethod = self.method
        request.allHTTPHeaderFields = self.headers
        request.httpBody = self.body as? Data
        
        print("🛜🛜🛜 API Request: \(request)")
        
        return request
    }
}
