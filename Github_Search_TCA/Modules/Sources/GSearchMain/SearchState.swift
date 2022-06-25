//
//  SearchState.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import Foundation
import ComposableArchitecture
import GSearchCell
import GEntities

public struct SearchState: Equatable {
  var showSignInView: Bool
  var isLoggedIn: Bool
  @BindableState var searchQuery: String
  var searchedResults: IdentifiedArrayOf<SearchCellState>
  var code: String
  var accessToken: AccessToken
  var countPerPage: Int
  var githubSignInURL: URL
  var pagination: Pagination
  var loginButtonText: String

  public init(
    showSignInView: Bool = false,
    isLoggedIn: Bool = false,
    searchQuery: String = "",
    searchedResults: IdentifiedArrayOf<SearchCellState> = [],
    code: String = "",
    accessToken: AccessToken = .empty,
    countPerPage: Int = 50,
    githubSignInURL: URL,
    pagination: Pagination = .empty,
    loginButtonText: String = "Login"
  ) {
    self.showSignInView = showSignInView
    self.isLoggedIn = isLoggedIn
    self.searchQuery = searchQuery
    self.searchedResults = searchedResults
    self.code = code
    self.accessToken = accessToken
    self.countPerPage = countPerPage
    self.githubSignInURL = githubSignInURL
    self.pagination = pagination
    self.loginButtonText = loginButtonText
  }
}


