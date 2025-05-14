//
//  IMDBApp.swift
//  IMDB
//
//  Created by Abhishek Shukla on 03/05/25.
//

import SwiftUI

let apptint = Color.green

@main
struct IMDBApp: App {
    
    @StateObject var viewModel: MovieListViewModel = MovieListViewModel(nowPlayingServicable: MoviesService())
    
    @StateObject var router: NavigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .environmentObject(viewModel)
                .environmentObject(router)
        }
    }
}
