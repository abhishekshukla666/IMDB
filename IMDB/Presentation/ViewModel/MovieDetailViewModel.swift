//
//  MovieDetailViewModel.swift
//  IMDB
//
//  Created by Abhishek Shukla on 14/05/25.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetailResponse?
    
    let movieService: MoviesServicable
    
    init(_ movieService: MoviesServicable) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchMovieDetail(movieId: Int) async {
        movieDetail = try? await movieService.getMovieDetails(id: movieId)
    }
}
