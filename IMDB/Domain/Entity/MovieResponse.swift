//
//  Untitled.swift
//  IMDB
//
//  Created by Abhishek Shukla on 04/05/25.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable, Identifiable, Hashable {
    
//    let adult: Bool
    let backdropPath: OptionalDataType?
//    let genreIDS: [Int]
    let id: Int
//    let originalLanguage: OriginalLanguage
    let originalTitle: OptionalDataType?
    let overview: OptionalDataType?
//    let popularity: Double
    let posterPath: OptionalDataType
    let releaseDate: OptionalDataType
    let title: OptionalDataType
//    let video: Bool
    let voteAverage: OptionalDataType?
    let voteCount: OptionalDataType?

    enum CodingKeys: String, CodingKey {
//        case adult
        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
        case id
//        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
//        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
//        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Decodable {
    case de = "de"
    case en = "en"
    case hi = "hi"
    case ja = "ja"
}


