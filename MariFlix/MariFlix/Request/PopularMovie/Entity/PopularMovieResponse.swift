//
//  PopularMovieResponse.swift
//  MariFlix
//
//  Created by Wellington on 17/06/22.
//

import Foundation

// MARK: - PopularMovieResponse
struct PopularMovieResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

