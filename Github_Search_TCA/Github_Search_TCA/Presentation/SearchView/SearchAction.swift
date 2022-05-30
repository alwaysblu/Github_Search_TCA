//
//  SearchAction.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

enum SearchAction {
    case searchQueryChanged(String)
    case githubUsersInformationResponse(Result<UserInformationPage, Error>)
    case fetchUsers
    case showSignInView
    case requestAccessToken
    case responseCode(String)
    case accessTokenResponse(Result<AccessToken, Error>)
    case searchCellResult(id: SearchCellState.ID, action: SearchCellAction)
}
