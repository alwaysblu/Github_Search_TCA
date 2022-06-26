//
//  SearchCellAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import GCommon
import GEntities
import GDTO

public enum SearchCellAction: Equatable {
    case requestUserDetailInformation
    case userDetailInformationResponse(Result<UserDetailInformationResponseDTO, Error>)
}

extension SearchCellAction {
  public static func == (lhs: SearchCellAction, rhs: SearchCellAction) -> Bool {
        switch (lhs, rhs) {
        case (.requestUserDetailInformation, .requestUserDetailInformation),
            (.userDetailInformationResponse, .userDetailInformationResponse):
            return true
        default:
            return false
        }
    }
}
