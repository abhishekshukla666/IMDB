//
//  NavigationManager.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import Foundation

final class NavigationManager: ObservableObject {
    @Published var routes: [Route] = .init()
    
    func push(_ route: Route) {
        routes.append(route)
    }
    
    func pop() {
        guard !routes.isEmpty else { return }
        _ = routes.popLast()
    }
    
    func reset() {
        routes.removeAll()
    }
}
