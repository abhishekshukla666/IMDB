//
//  PMImageRetriver.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//
//

import Foundation

struct PMImageRetriver {
    
    func fetch(_ imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw PMImageError.invalidURL
        }
        
        debugPrint("👓👓👓Images API Call: \(url)")
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension PMImageRetriver {
    enum PMImageError: Error {
        case invalidURL
    }
}
