//
//  ReviewsResponse.swift
//  MariFlix
//
//  Created by Wellington on 02/07/22.
//

import Foundation

// MARK: - ReviewsResponse
struct ReviewsResponse: Codable {
    let results: [Reviews]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

