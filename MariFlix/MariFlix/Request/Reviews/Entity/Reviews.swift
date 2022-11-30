//
//  Reviews.swift
//  MariFlix
//
//  Created by Wellington on 02/07/22.
//

import Foundation

// MARK: - Reviews
struct Reviews: Codable {
    let authorDetails: AuthorDetails?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case authorDetails = "author_details"
        case content
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}


