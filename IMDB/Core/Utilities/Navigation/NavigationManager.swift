//
//  NavigationManager.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import Foundation

final class NavigationManager: ObservableObject {
    @Published var routes: [Route] = .init()
    @Published var favRoutes: [Route] = .init()
    
    
    func push(_ route: Route, _ appScreen: AppScreen = .home) {
        switch appScreen {
        case .home:
            routes.append(route)
        case .favorites:
            favRoutes.append(route)
        }
    }
    
    func pop(_ appScreen: AppScreen = .home) {
        switch appScreen {
        case .home:
            guard !routes.isEmpty else { return }
            _ = routes.popLast()
        case .favorites:
            guard !favRoutes.isEmpty else { return }
            _ = favRoutes.popLast()
        }
        
    }
    
    func reset(_ appScreen: AppScreen = .home) {
        switch appScreen {
        case .home:
            routes.removeAll()
        case .favorites:
            favRoutes.removeAll()
        }
    }
}
