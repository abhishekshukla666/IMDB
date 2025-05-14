//
//  Networkable.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation
import Combine


extension URLSession {
    static let shared: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10 // seconds
        return URLSession(configuration: configuration)
    }()
}

protocol Networkable {
    func sendRequest<T: Decodable>(session: URLSession, endpoint: EndPoint) async throws -> T
    func sendRequest<T: Decodable>(endpoint: EndPoint, resultHandler: @escaping (Result<T, NetworkError>) -> Void)
    func sendRequest<T: Decodable>(endpoint: EndPoint, type: T.Type) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: Networkable {
    
    static let shared: NetworkManager = .init()
    private init() {}
    
    //MARK: With Closure
    func sendRequest<T: Decodable>(endpoint: EndPoint, resultHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            resultHandler(.failure(.invalidURL))
            return
        }
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                guard error == nil else {
                    resultHandler(.failure(.invalidURL))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    resultHandler(.failure(.unexpectedStatusCode))
                    return
                }
                guard let data = data else {
                    resultHandler(.failure(.unknown))
                    return
                }
                
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                resultHandler(.success(decodedResponse))
            } catch (let error as DecodingError) {
                resultHandler(.failure(.decode(error: error)))
            } catch (let error) {
                resultHandler(.failure(.custom(error: error)))
            }
        }
        urlTask.resume()
    }
    
    //MARK: With Combine
    func sendRequest<T>(endpoint: EndPoint, type: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            precondition(false, "Failed URLRequest")
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    throw NetworkError.invalidURL
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if error is DecodingError {
                    return NetworkError.decode(error: error)
                } else if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: With Async & Await
    func sendRequest<T: Decodable>(session: URLSession = .shared, endpoint: EndPoint) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw NetworkError.decode(error: NetworkError.noResponse)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = session
                .dataTask(with: urlRequest) { data, response, _ in
                    do {
                        guard response is HTTPURLResponse else {
                            continuation.resume(throwing: NetworkError.invalidURL)
                            return
                        }
                        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                            continuation.resume(throwing:
                                                    NetworkError.unexpectedStatusCode)
                            return
                        }
                        guard let data = data else {
                            continuation.resume(throwing: NetworkError.unknown)
                            return
                        }
                        
                        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: decodedResponse)
                    } catch (let error as DecodingError) {
                        debugPrint(error.prettyDescription)
                        continuation.resume(throwing: NetworkError.decode(error: error))
                    } catch (let error) {
                        continuation.resume(throwing: NetworkError.custom(error: error))
                    }
                }
            task.resume()
        }
    }
}

extension Networkable {
    fileprivate func createRequest(endPoint: EndPoint) -> URLRequest? {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return nil }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: "f1903be2b881067835c39fa6f8990a95")]
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)

        /// Configure the HTTP method.
        request.httpMethod = "GET"
        return request
    }
    
    
    
    private func prepareRequestBody(endpoint: EndPoint) -> Data? {
        var isContentTypeApplicationJSON = false
        if let headers = endpoint.headers {
            if let contentType = headers.first(where: { $0.key == "Content-Type" })?.value {
                print("Content-Type is: \(contentType)")
                
                if contentType == "application/json" || contentType == "application/json;charset=utf-8" {
                    isContentTypeApplicationJSON = true
                } else if contentType == "application/x-www-form-urlencoded" {
                    isContentTypeApplicationJSON = false
                }
            } else {
                print("Content-Type header not found.")
                isContentTypeApplicationJSON = false
            }
        }
        
        // Handle the body based on its type
        if let body = endpoint.body {
            do {
                if isContentTypeApplicationJSON {
                    // Convert the body to JSON
                    let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                    print("---- API Parameters: ", String(data: jsonData, encoding: .utf8) ?? "")
                    return jsonData
                } else if let bodyDict = body as? [String: Any] {
                    // URL-encoded format
                    let parameterArray = bodyDict.compactMap { key, value -> String? in
                        if let stringValue = value as? String {
                            return "\(key)=\(stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                        }
                        return nil
                    }
                    let parameterString = parameterArray.joined(separator: "&")
                    print("---- API Parameters: ", parameterString)
                    return parameterString.data(using: .utf8)
                } else if let bodyArray = body as? [[String: Any]], isContentTypeApplicationJSON {
                    // Convert the array to JSON
                    let jsonData = try JSONSerialization.data(withJSONObject: bodyArray, options: [])
                    print("---- API Parameters: ", String(data: jsonData, encoding: .utf8) ?? "")
                    return jsonData
                }
            } catch {
                print("Error encoding parameters: \(error)")
                return nil
            }
        }
        return nil
    }
}
fileprivate extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:\(String(describing: self.httpBody))")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}
