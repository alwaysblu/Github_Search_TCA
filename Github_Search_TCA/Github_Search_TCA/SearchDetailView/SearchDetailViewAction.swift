//
//  SearchDetailViewAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation

enum SearchDetailViewAction {
    case requestUserDetailInformation
    case userDetailInformationResponse(Result<UserDetailInformation, Error>)
}
