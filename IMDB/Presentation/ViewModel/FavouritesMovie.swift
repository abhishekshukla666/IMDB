//
//  FavouritesMovie.swift
//  IMDB
//
//  Created by Abhishek Shukla on 24/05/25.
//

import SwiftUI

final class FavoritesMovie: ObservableObject {
    
    private var movieIds: Set<Int>
    private let key = "Favorites"
    
    init() {
        movieIds = []
    }
    
    func contains(_ movie: Movie) -> Bool {
        movieIds.contains(movie.id)
    }
    
    func add(_ movie: Movie) {
        movieIds.insert(movie.id)
        save()
    }
    
    func remove(_ movie: Movie) {
        movieIds.remove(movie.id)
        save()
    }
    
    func save() {
        UserDefaults.standard.set(Array(movieIds), forKey: key)
    }
    
    func load() -> Set<Int> {
        let ids = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        return Set(ids)
    }
}
