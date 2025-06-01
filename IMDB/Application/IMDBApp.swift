//
//  IMDBApp.swift
//  IMDB
//
//  Created by Abhishek Shukla on 03/05/25.
//

import SwiftUI

@main
struct IMDBApp: App {
    
    @StateObject var router: NavigationManager = NavigationManager()
    var body: some Scene {
        WindowGroup {
            MoviesTabView()
                .environmentObject(router)
        }
    }
}
