//
//  DetailsMovieResponse.swift
//  MariFlix
//
//  Created by Wellington on 24/06/22.
//

import Foundation

// MARK: - MovieResponse

struct DetailsMovieResponse: Codable {
    
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let status, tagline, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path = "backdrop_path"
        case  id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case status, tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
}
