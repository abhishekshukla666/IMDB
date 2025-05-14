//
//  Route.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import SwiftUI

enum Route {
    case commonListView(movieListType: MovieListType)
}

extension Route: Hashable {
    static func ==(lhs: Route, rhs: Route) -> Bool {
        switch(lhs, rhs) {
        case (.commonListView(let lhsmovieListType), .commonListView(let rhsmovieListType)):
            return lhsmovieListType == rhsmovieListType
        }
    }
}

extension Route: View {
    var body: some View {
        switch self {
        case .commonListView(let movieListType):
            CommonMovieListView(movieListType: movieListType)
        }
    }
}
