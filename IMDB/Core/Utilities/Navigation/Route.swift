//
//  Route.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import SwiftUI

enum Route {
    case commonListView(movieListType: MovieListType)
    case movieDetailView(movieId: Int)
}

extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.movieDetailView(let lhsMovieId), .movieDetailView(let rhsMovieId)):
            return lhsMovieId == rhsMovieId
        case (.commonListView(let lhsMovieListType), .commonListView(let rhsMovieListType)):
            return lhsMovieListType == rhsMovieListType
        default:
            return false
        }
    }
    
}

extension Route: View {
    var body: some View {
        switch self {
        case .commonListView(let movieListType):
            CommonMovieListView(movieListType: movieListType)
        case .movieDetailView(let movieId):
            MovieDetailView(movieId: movieId)
        }
    }
}
