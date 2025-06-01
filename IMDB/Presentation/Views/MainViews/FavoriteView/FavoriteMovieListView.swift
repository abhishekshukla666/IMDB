//
//  FavoriteMovieListView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 24/05/25.
//

import SwiftUI

struct FavoriteMovieListView: View {
    
    @EnvironmentObject var navigationPath: NavigationManager
    @EnvironmentObject var movieListVM: MovieListViewModel
    @StateObject private var favoriteMovieVM = FavoritesMovie()
    
    var body: some View {
        NavigationStack(path: $navigationPath.favRoutes) {
            ScrollView {
                LazyVStack {
                    ForEach(movies(for: favoriteMovieVM.load())) { movie in
                        MovieView(isFromFavorites: true, movie: movie)
                            .onTapGesture {
                                navigationPath
                                    .push(
                                        .movieDetailView(movieId: movie.id),
                                        .favorites
                                    )
                            }
                        Divider()
                        
                    }
                }
            }
                .listStyle(.plain)
            .navigationTitle("Favorites")
        }
    }
    
    fileprivate func movies(for ids: Set<Int>?) -> [Movie] {
        guard let ids else { return [] }
        let nowPlayingMovies = movieListVM.nowPlayingMovies.filter({ ids.contains($0.id) })
        let upcomingMovies = movieListVM.upcomingMovies.filter({ ids.contains($0.id) })
        let popularMovies = movieListVM.popularMovies.filter({ ids.contains($0.id) })
        let topRatedMovies = movieListVM.topRatedMovies.filter({ ids.contains($0.id) })
        return (nowPlayingMovies + upcomingMovies + popularMovies + topRatedMovies)
    }
}

#Preview {
    FavoriteMovieListView()
        .environmentObject(NavigationManager())
        .environmentObject(MovieListViewModel())
}
