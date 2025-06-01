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
        
        url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=f1903be2b881067835c39fa6f8990a95")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func test_with_sucessfull_response_is_Valid() async throws {
        
        guard let path = Bundle.main.path(forResource: "NowPlaying1", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail( "File not found!" )
            return
        }
        guard let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil) else { return }
        
        MockURLProtocol.requestHandler = { request in
            return (response, data)
        }
        
        let moviesService: MoviesServicable = MoviesService()
        let movies = try await moviesService.getNowPlayingMovies(
            session: session,
            page: "1"
        )
        
        let staticJSON = try JSONDecoder().decode(
            MovieResponse.self,
            from: data
        )
        XCTAssertEqual(movies, staticJSON, "The response is not equal")
    }
}
