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
                LazyVStack(alignment: .center, pinnedViews: [.sectionHeaders]) {
                    if movieListViewModel.isLoadingNowPlayingMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else if movieListViewModel.nowPlayingMovies.count > 0 {
                        MoviesCarousalView(headerTitle: "Now Playing", movies: movieListViewModel.nowPlayingMovies) {
                            path.push(.commonListView(movieListType: .nowPlaying))
                            
                        }
                    }
                    if movieListViewModel.isLoadingPopularMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else if movieListViewModel.popularMovies.count > 0 {
                        MoviesCarousalView(headerTitle: "Popular", movies: movieListViewModel.popularMovies) {
                            path.push(.commonListView(movieListType: .popular))
                        }
                    }
                    if movieListViewModel.isLoadingUpcomingMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else if movieListViewModel.upcomingMovies.count > 0 {
                        MoviesCarousalView(headerTitle: "Upcoming", movies: movieListViewModel.upcomingMovies) {
                            path.push(.commonListView(movieListType: .upcoming))
                        }
                    }
                    if movieListViewModel.isLoadingTopRatedMovies {
                        ProgressView()
                            .tint(apptint)
                            .padding()
                    } else if movieListViewModel.topRatedMovies.count > 0 {
                        MoviesCarousalView(headerTitle: "Top Rated", movies: movieListViewModel.topRatedMovies) {
                            path.push(.commonListView(movieListType: .topRated))
                        }
                    }
                    
                    if movieListViewModel.nowPlayingMovies.count == 0 &&
                        movieListViewModel.popularMovies.count == 0 &&
                        movieListViewModel.upcomingMovies.count == 0 &&
                        movieListViewModel.topRatedMovies.count == 0 &&
                        !movieListViewModel.isLoadingNowPlayingMovies &&
                        !movieListViewModel.isLoadingPopularMovies &&
                        !movieListViewModel.isLoadingTopRatedMovies &&
                        !movieListViewModel.isLoadingUpcomingMovies {
                        ContentUnavailableView("No Movies Found", systemImage: "movieclapper")
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
            await movieListViewModel.fetchTopRatedMovies(page: "1")
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
