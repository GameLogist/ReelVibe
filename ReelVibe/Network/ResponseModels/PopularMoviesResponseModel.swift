//
//  PopularMoviesResponseModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

// MARK: - PopularMoviesResponseModel
struct PopularMoviesResponseModel: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
