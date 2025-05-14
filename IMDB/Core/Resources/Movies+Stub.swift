//
//  Movies+Stub.swift
//  IMDB
//
//  Created by Abhishek Shukla on 09/05/25.
//

import Foundation


extension MovieResponse {
    
    static func stubbedMovieResponse(fileName: String) -> MovieResponse? {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: fileName)
        return response ?? nil
    }
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
