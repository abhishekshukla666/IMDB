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
    
    @Published var isLoadingNowPlayingMovies: Bool = false
    @Published var isLoadingPopularMovies: Bool = false
    @Published var isLoadingUpcomingMovies: Bool = false
    let moviesServicable: MoviesServicable
    
    init(nowPlayingServicable: MoviesServicable = MoviesService()) {
        self.moviesServicable = nowPlayingServicable
    }
    
    @MainActor
    func fetchNowPlayingMovies(page: String) async {
        guard !isLoadingNowPlayingMovies else { return }
        isLoadingNowPlayingMovies = true
        do {
            let moviesResponse = try await self.moviesServicable.getNowPlayingMovies(page: page)
            self.nowPlayingMovies = moviesResponse.movies
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
            let moviesResponse = try await self.moviesServicable.getPopularMovies(page: page)
            self.popularMovies = moviesResponse.movies
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
            let moviesResponse = try await self.moviesServicable.getUpcomingMovies(page: page)
            self.upcomingMovies = moviesResponse.movies
            isLoadingUpcomingMovies = false
        } catch {
            isLoadingUpcomingMovies = false
            print("Error fetching upcoming movies")
        }
    }
}
