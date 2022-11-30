//
//  SimilarMovie.swift
//  MariFlix
//
//  Created by Wellington on 20/09/22.
//

import Foundation

struct SimilarMovieResponse: Codable {
    let page: Int
    let results: [SimilarMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

