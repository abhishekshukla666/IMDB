//
//  MovieListView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 03/05/25.
//

import SwiftUI

struct MovieListView: View {

    @EnvironmentObject var movieListViewModel: MovieListViewModel
    @EnvironmentObject var path: NavigationManager
    
    var body: some View {
        NavigationStack(path: $path.routes) {
            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                    if movieListViewModel.isLoadingNowPlayingMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else {
                        MoviesCarousalView(headerTitle: "Now Playing", movies: movieListViewModel.nowPlayingMovies) {
                            path.push(.commonListView(movieListType: .nowPlaying))
                            
                        }
                    }
                    if movieListViewModel.isLoadingPopularMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else {
                        MoviesCarousalView(headerTitle: "Popular", movies: movieListViewModel.popularMovies) {
                            path.push(.commonListView(movieListType: .popular))
                        }
                    }
                    if movieListViewModel.isLoadingUpcomingMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else {
                        MoviesCarousalView(headerTitle: "Upcoming", movies: movieListViewModel.upcomingMovies) {
                            path.push(.commonListView(movieListType: .upcoming))
                        }
                    }
                }
            }
            .navigationTitle(Text("IMDB"))
            .navigationDestination(for: Route.self) { $0 }
        }
        .task {
            await movieListViewModel.fetchNowPlayingMovies(page: "1")
            await movieListViewModel.fetchPopularMovies(page: "1")
            await movieListViewModel.fetchUpcomingMovies(page: "1")
        }
        .onAppear {
            print("Appeared")
        }
    }
}

#Preview {
    MovieListView()
        .environmentObject(MovieListViewModel())
}
