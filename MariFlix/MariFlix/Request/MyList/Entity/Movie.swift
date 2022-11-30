//
//  Movie.swift
//  MariFlix
//
//  Created by Wellington on 26/06/22.
//

struct LocalMovie: Codable {
    var movieID: Int
    var backdrop_path: String
    var originalTitle: String
    var releaseDate: String
    var voteAverage: Double
    var overview: String
}
