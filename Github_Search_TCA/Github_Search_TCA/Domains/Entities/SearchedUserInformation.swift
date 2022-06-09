//
//  UserInformation.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import Foundation

struct SearchedUserInformation {
    let userName: String
    let profileUrl: String
}

struct UserInformationPage { 
    var totalCount: Int
    var informations: [SearchedUserInformation]
    var pagination: Pagination
}

struct Pagination: Equatable {
    var nextUrl: String
    var isFirst: Bool
    var isLast: Bool
}

extension Pagination {
    static let empty = Pagination(nextUrl: "", isFirst: false, isLast: false)
}
