//
//  UserInformation.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct SearchedUserInformation {
    let userName: String
    let profileUrl: String
}

struct UserInformationPage {
    var totalCount: Int
    var informations: [SearchedUserInformation]
}
