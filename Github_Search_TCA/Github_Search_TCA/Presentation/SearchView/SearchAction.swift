//
//  SearchAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import Foundation
import ComposableArchitecture

enum SearchAction: BindableAction {
    case githubUsersInformationResponse(Result<(UserInformationPage, URLResponse), Error>)
    case fetchUsers
    case showSignInView
    case requestAccessToken
    case responseCode(URL)
    case accessTokenResponse(Result<AccessToken, Error>)
    case searchCellResult(id: SearchCellState.ID,
                          action: SearchCellAction)
    case binding(BindingAction<SearchState>)
}
