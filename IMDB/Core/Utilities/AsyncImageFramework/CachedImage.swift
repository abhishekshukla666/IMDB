//
//  CachedImage.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import SwiftUI

struct CachedImage<Content: View>: View {
    
    @StateObject private var manager = CachedImageManager()
    let imageURL: String
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
                content(.empty)
            case .loaded(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                } else {
                    content(.failure(AsyncImageError.invalidImageData))
                }
            case .error(let error):
                content(.failure(error))
            case .none:
                content(.empty)
            }
        }
        .task {
            await manager.load(imageURL)
        }
    }
}

extension CachedImage {
    enum AsyncImageError: Error {
        case invalidImageData
    }
}
