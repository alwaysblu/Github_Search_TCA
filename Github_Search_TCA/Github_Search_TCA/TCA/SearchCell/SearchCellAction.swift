//
//  SearchCellAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation

enum SearchCellAction: Equatable {
    case requestUserDetailInformation
    case userDetailInformationResponse(Result<UserDetailInformation, Error>)
}

extension SearchCellAction {
    static func == (lhs: SearchCellAction, rhs: SearchCellAction) -> Bool {
        switch (lhs, rhs) {
        case (.requestUserDetailInformation, .requestUserDetailInformation),
            (.userDetailInformationResponse, .userDetailInformationResponse):
            return true
        default:
            return false
        }
    }
}
