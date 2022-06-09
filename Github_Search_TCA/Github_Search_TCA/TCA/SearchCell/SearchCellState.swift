//
//  SearchCellState.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import Foundation

struct SearchCellState: Equatable, Identifiable {
    let imageUrl: String
    let userName: String
    let id: UUID?
    var userDetailInformation: UserDetailInformation = .empty
    var isUserDataExist = false
    var accessToken: AccessToken = .empty
}
