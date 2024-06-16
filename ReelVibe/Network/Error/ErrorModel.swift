//
//  ErrorModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

import Foundation

struct ErrorModel: Codable, Error {
    let errors: [ErrorSummary]
}

// MARK: - Error
struct ErrorSummary: Codable {
    var code: String?
    var reason: String
    var datetime: ErrorTimeStamp?
}

// MARK: - ErrorTimeStamp
struct ErrorTimeStamp: Codable {
    let value: String
    let timezone: String
}
