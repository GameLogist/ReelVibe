//
//  NowPlayingMoviesResponseModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 15/06/24.
//

import Foundation
// MARK: - NowPlayingMoviesResponseModel
struct NowPlayingResponseModel: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
