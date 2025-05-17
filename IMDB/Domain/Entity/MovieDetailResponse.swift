//
//  MovieDetials.swift
//  IMDB
//
//  Created by Abhishek Shukla on 14/05/25.
//

import Foundation

struct MovieDetailResponse: Codable, Hashable {
    static func == (lhs: MovieDetailResponse, rhs: MovieDetailResponse) -> Bool {
        return lhs.id == rhs.id && lhs.posterPath == rhs.posterPath
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(posterPath)
    }
    
    let adult: OptionalDataType?
    let backdropPath: OptionalDataType?
    let budget: OptionalDataType?
    let genres: [Genre]?
    let homepage: OptionalDataType?
    let id: OptionalDataType?
    let imdbID: OptionalDataType?
    let originalLanguage: OptionalDataType?
    let originalTitle: OptionalDataType?
    let overview: OptionalDataType?
    let popularity: OptionalDataType?
    let posterPath: OptionalDataType?
    let releaseDate: OptionalDataType?
    let revenue, runtime: OptionalDataType?
    let status: OptionalDataType?
    let tagline: OptionalDataType?
    let title: OptionalDataType?
    let video: OptionalDataType?
    let voteAverage: OptionalDataType?
    let voteCount: OptionalDataType?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: OptionalDataType?
    let name: OptionalDataType?
}
