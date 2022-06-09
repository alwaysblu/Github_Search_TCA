//
//  SearchDetailViewState.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation

struct SearchDetailViewState: Equatable {
    var userDetailInformation: UserDetailInformation = .empty
    var userName = ""
    var accessToken: AccessToken = .empty
}
