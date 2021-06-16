//
//  MovieResult.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct MoviesResult {
    let region: String?
    let totalPages: Int?
    let totalResults: Int?
    let movies: [Movie]?
}

// MARK: - Public: Codable

extension MoviesResult: Codable {
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
        case region
    }
}
