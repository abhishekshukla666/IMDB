//
//  CommonMovieListViewModel.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import Foundation

enum MovieListType {
    case nowPlaying
    case popular
    case upcoming
    case topRated
}
class CommonMovieListViewModel: ObservableObject {
    
    private(set) var movieResponse: MovieResponse?
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false

    private var currentPage: Int = 1
    private var canLoadMorePages = true
    
    let movieService: MoviesServicable
    
    init(movieService: MoviesServicable) {
        self.movieService = movieService
    }
    
    fileprivate func handleMovieResponse(_ movieResponse: MovieResponse?) {
        guard let movieResponse else {
            hasError = true
            isLoading = false
            return
        }
        self.movies.append(contentsOf: movieResponse.movies.sortByDate())
        filteredMovies = movies
        isLoading = false
        currentPage += 1
        self.canLoadMorePages = movieResponse.movies.count < movieResponse.totalPages
    }
    
    @MainActor
    func getMovies(_ movieListType: MovieListType) async {
        guard !isLoading && canLoadMorePages else { return }
        isLoading = true
        switch movieListType {
        case .nowPlaying:
            do {
                movieResponse = try await movieService.getNowPlayingMovies(page: String(currentPage))
                handleMovieResponse(movieResponse)
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
        case .popular:
            do {
                movieResponse = try await movieService.getPopularMovies(page: String(currentPage))
                handleMovieResponse(movieResponse)
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .upcoming:
            do {
                movieResponse = try await movieService.getUpcomingMovies(page: String(currentPage))
                handleMovieResponse(movieResponse)
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .topRated:
            do {
                movieResponse = try await movieService.getTopRatedMovies(page: String(currentPage))
                handleMovieResponse(movieResponse)
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
            
        }
    }
}
