//
//  NowPlayingService.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

protocol MoviesServicable {
    func getNowPlayingMovies(page: String) async throws -> MovieResponse?
    func getPopularMovies(page: String) async throws -> MovieResponse?
    func getUpcomingMovies(page: String) async throws -> MovieResponse?
    func getTopRatedMovies(page: String) async throws -> MovieResponse?
    func getMovieDetails(id: Int) async throws -> MovieDetailResponse?
}

struct MoviesService: MoviesServicable {
    func getNowPlayingMovies(page: String) async throws -> MovieResponse? {
        return try await NetworkManager.shared.sendRequest(session: .shared, endpoint: IMDBEndPoint.nowPlaying(page: page))
    }
    
    func getPopularMovies(page: String) async throws -> MovieResponse? {
        return try await NetworkManager.shared.sendRequest(session: .shared, endpoint: IMDBEndPoint.popular(page: page))
    }
    
    func getUpcomingMovies(page: String) async throws -> MovieResponse? {
        return try await NetworkManager.shared.sendRequest(session: .shared, endpoint: IMDBEndPoint.upcoming(page: page))
    }
    
    func getTopRatedMovies(page: String) async throws -> MovieResponse? {
        return try await NetworkManager.shared.sendRequest(session: .shared, endpoint: IMDBEndPoint.topRated(page: page))
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetailResponse? {
        return try await NetworkManager.shared.sendRequest(session: .shared, endpoint: IMDBEndPoint.details(id: id))
    }
}
