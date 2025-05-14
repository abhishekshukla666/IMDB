//
//  NowPlayingService.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

protocol MoviesServicable {
    func getNowPlayingMovies(page: String) async throws -> MovieResponse
    func getPopularMovies(page: String) async throws -> MovieResponse
    func getUpcomingMovies(page: String) async throws -> MovieResponse
    
}

struct MoviesService: MoviesServicable {
    func getNowPlayingMovies(page: String) async throws -> MovieResponse {
        return try await NetworkManager.shared.sendRequest(endpoint: IMDBEndPoint.nowPlaying(page: page))
    }
    
    func getPopularMovies(page: String) async throws -> MovieResponse {
        return try await NetworkManager.shared.sendRequest(endpoint: IMDBEndPoint.popular(page: page))
    }
    
    func getUpcomingMovies(page: String) async throws -> MovieResponse {
        return try await NetworkManager.shared.sendRequest(endpoint: IMDBEndPoint.upcoming(page: page))
    }
}
