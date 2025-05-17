//
//  MovieListViewModel.swift
//  IMDB
//
//  Created by Abhishek Shukla on 04/05/25.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    
    @Published var isLoadingNowPlayingMovies: Bool = false
    @Published var isLoadingPopularMovies: Bool = false
    @Published var isLoadingUpcomingMovies: Bool = false
    @Published var isLoadingTopRatedMovies: Bool = false
    let moviesServicable: MoviesServicable
    
    init(nowPlayingServicable: MoviesServicable = MoviesService()) {
        self.moviesServicable = nowPlayingServicable
    }
    
    @MainActor
    func fetchNowPlayingMovies(page: String) async {
        guard !isLoadingNowPlayingMovies else { return }
        isLoadingNowPlayingMovies = true
        do {
            if let moviesResponse = try await self.moviesServicable.getNowPlayingMovies(page: page) {
                self.nowPlayingMovies = moviesResponse.movies.sortByDate()
                    
            }
            isLoadingNowPlayingMovies = false
        } catch {
            isLoadingNowPlayingMovies = false
            print("Error fetching now playing movies")
        }
    }
    
    @MainActor
    func fetchPopularMovies(page: String) async {
        guard !isLoadingPopularMovies else { return }
        isLoadingPopularMovies = true
        do {
            if let moviesResponse = try await self.moviesServicable.getPopularMovies(page: page) {
                self.popularMovies = moviesResponse.movies.sortByDate()
            }
            isLoadingPopularMovies = false
        } catch {
            isLoadingPopularMovies = false
            print("Error fetching popular movies")
        }
    }
    
    @MainActor
    func fetchUpcomingMovies(page: String) async {
        guard !isLoadingUpcomingMovies else { return }
        isLoadingUpcomingMovies = true
        do {
            if let moviesResponse = try await self.moviesServicable.getUpcomingMovies(page: page) {
                self.upcomingMovies = moviesResponse.movies.sortByDate()
            }
            isLoadingUpcomingMovies = false
        } catch {
            isLoadingUpcomingMovies = false
            print("Error fetching upcoming movies")
        }
    }
    
    @MainActor
    func fetchTopRatedMovies(page: String) async {
        guard !isLoadingTopRatedMovies else { return }
        isLoadingTopRatedMovies = true
        do {
            if let moviesResponse = try await self.moviesServicable.getTopRatedMovies(page: page) {
                self.topRatedMovies = moviesResponse.movies.sortByDate()
            }
            isLoadingTopRatedMovies = false
        } catch {
            isLoadingTopRatedMovies = false
            print("Error fetching top_rated movies")
        }
    }
}
