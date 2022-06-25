//
//  SearchAction.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import Foundation
import ComposableArchitecture
import GEntities
import GSearchCell

public enum SearchAction: BindableAction, Equatable {
  case githubUsersInformationResponse(Result<UserInformationPage, Error>)
  case fetchUsers
  case showSignInView
  case requestAccessToken
  case handleResponse(URL)
  case accessTokenResponse(Result<AccessToken, Error>)
  case searchCellResult(
    id: SearchCellState.ID,
    action: SearchCellAction
  )
  case binding(BindingAction<SearchState>)
  case responseURL(BaseURL)
}

extension SearchAction {
  public static func == (lhs: SearchAction, rhs: SearchAction) -> Bool {
    switch (lhs, rhs) {
    case (.githubUsersInformationResponse, .githubUsersInformationResponse),
      (.fetchUsers, .fetchUsers),
      (.showSignInView, .showSignInView),
      (.requestAccessToken, .requestAccessToken),
      (.handleResponse, .handleResponse),
      (.accessTokenResponse, .accessTokenResponse),
      (.searchCellResult, .searchCellResult),
      (.binding, .binding),
      (.responseURL, .responseURL):
      return true
    default:
      return false
    }
  }
}

public enum BaseURL: Equatable {

}
