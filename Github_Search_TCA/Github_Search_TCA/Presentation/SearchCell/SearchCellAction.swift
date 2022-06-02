//
//  SearchCellAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation

enum SearchCellAction {
    case detail(SearchDetailViewAction)
    case requestUserDetailInformation(String)
    case userDetailInformationResponse(Result<UserDetailInformation, Error>)
}
