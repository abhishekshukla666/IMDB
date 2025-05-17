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
    
    @State private var searchableText: String = ""

    init(movieListType: MovieListType) {
        self.movieListType = movieListType
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredMovies, id: \.self) { movie in
                    MovieView(movie: movie)
                        .onAppear {
                            loadMoreIfNeeded(movie)
                        }
                    Divider()
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
        }
        .navigationTitle(movieListType == .nowPlaying ? "Now Playing" : "Popular")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchableText, prompt: "Search Movies")
        .onChange(of: searchableText) { (_, newValue) in
            if newValue.isEmpty {
                viewModel.filteredMovies = viewModel.movies
            } else {
                viewModel.filteredMovies = viewModel.movies
                    .filter {
                        $0.title
                            .toString()
                            .localizedStandardContains(newValue.localizedLowercase)
                    }
            }
        }
    }
    
    func navigationTitle() -> String {
        switch movieListType {
            case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        }
    }
    
    func loadMoreIfNeeded(_ movie: Movie) {
        if viewModel.movies.last == movie {
            Task {
                await viewModel.getMovies(movieListType)
            }
        }
    }
}

#Preview {
    CommonMovieListView(movieListType: .nowPlaying)
        .environmentObject(CommonMovieListViewModel(movieService: MoviesService()))
}
