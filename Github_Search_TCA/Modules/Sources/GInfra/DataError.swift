//
//  DataError.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

enum DataError: Error {
    case invalidURL
    case invalidData
    case statusCode
    case invalidResponse
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "<Error> Invalid URL"
        case .invalidData:
            return "<Error> Invalid Data."
        case .statusCode:
            return "<Error> Status code is not between 200 and 299 ."
        case .invalidResponse:
            return "<Error> Invalid Response."
        }
    }
}
