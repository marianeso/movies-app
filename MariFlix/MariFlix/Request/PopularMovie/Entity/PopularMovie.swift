//
//  Response.swift
//  MariFlix
//
//  Created by Wellington on 17/06/22.
//

import Foundation

// MARK: - Result
struct Movie: Codable {
    var id: Int?
    var originalTitle, overview: String?
    var backdrop_path, title: String?
    var voteAverage: Double?
    var releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case backdrop_path = "backdrop_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
