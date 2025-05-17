
//
//  Untitled.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

public typealias BodyType = Any

let accessToken = Bundle.infoPlistValue(forKey: "accessToken")

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
