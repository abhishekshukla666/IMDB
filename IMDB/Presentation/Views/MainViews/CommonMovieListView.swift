//
//  CommonMovieListView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import SwiftUI

struct CommonMovieListView: View {
    
    @EnvironmentObject var path: NavigationManager
    @StateObject var viewModel: CommonMovieListViewModel = .init(movieService: MoviesService())
    let movieListType: MovieListType

    init(movieListType: MovieListType) {
        self.movieListType = movieListType
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.movies, id: \.self) { movie in
                    MovieView(movie: movie)
                        .onAppear {
                            loadMoreIfNeeded(movie)
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(apptint)
                        .padding()
                }
            }
            .onAppear {
                Task {
                    await viewModel.getMovies(movieListType)
                }
            }
//            .onChange(of: viewModel.movies.count) { (oldValue, newValue) in
//                loadMoreIfNeeded()
//            }
        }
        .navigationTitle(movieListType == .nowPlaying ? "Now Playing" : "Popular")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func loadMoreIfNeeded(_ movie: Movie) {
        if viewModel.movies.last == movie {
            Task {
                await viewModel.getMovies(movieListType)
            }
        }
    }
}
