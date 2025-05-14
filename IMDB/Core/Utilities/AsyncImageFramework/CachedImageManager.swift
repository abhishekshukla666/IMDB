//
//  CachedImageManager.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//


import Foundation

final class CachedImageManager: ObservableObject {
    @Published private(set) var currentState: CurrentState?
    
    private let imageRetriever = PMImageRetriver()
    
    @MainActor
    func load(_ imageUrl: String,
              cache: PMImageCache = .shared) async {
       
        currentState = .loading
        if let imageData = cache.object(forKey: imageUrl) {
            currentState = .loaded(data: imageData)
            return
        }
        
        do {
            let data = try await imageRetriever.fetch(imageUrl)
            currentState = .loaded(data: data)
            cache.setObject(data, forKey: imageUrl)
        } catch {
            currentState = .error(error: error)
        }
    }
    
    
}

extension CachedImageManager {
    enum CurrentState {
        case loading
        case loaded(data: Data)
        case error(error: Error)
    }
}
