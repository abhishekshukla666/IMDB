//
//  HomeTabView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 22/05/25.
//

import SwiftUI

let apptint = Color.purple

enum AppScreen: Identifiable, CaseIterable {
    case home
    case favorites
    
    var id: AppScreen { self }
    
    var title: String {
        switch self {
        case .home: "Home"
        case .favorites: "Favorites"
        }
    }
    
    var icon: String {
        switch self {
        case .home: "house"
        case .favorites: "heart"
        }
    }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        Label(self.title, systemImage: self.icon)
    }
    
    @ViewBuilder
    var visibleView: some View {
        switch self {
        case .home: MovieListView()
        case .favorites: FavoriteMovieListView()
        }
    }
}

struct AppTabView: View {
    var body: some View {
        TabView {
            ForEach(AppScreen.allCases) { screen in
                screen.visibleView
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
        .tint(apptint)
    }
}

struct MoviesTabView: View {
    
    @StateObject var movieListVM: MovieListViewModel = MovieListViewModel(movieService: MoviesService())
    @StateObject var favoritesMovie: FavoritesMovie = FavoritesMovie()
    var body: some View {
        AppTabView()
            .environmentObject(movieListVM)
            .environmentObject(favoritesMovie)
    }
}

#Preview {
    MoviesTabView()
        .environmentObject(NavigationManager())
        .environmentObject(MovieListViewModel())
}
