//
//  HTTPClient.swift
//  IMDB
//
//  Created by Abhishek Shukla on 15/05/25.
//

import XCTest
@testable import IMDB

class MovieServiceTest: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        
        url = URL(string: "https://www.imdb.com/")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func test_with_sucessfull_response_is_Valid() async throws {
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]) else { return }
        
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(Movie.sampleData_Multiples)
        
        MockURLProtocol.requestHandler = { request in
            return (response, data)
        }
        
        let response = try await NetworkManager.shared.sendRequest(session: session, endpoint: IMDBEndPoint.nowPlaying(page: "1"))
    }
}
