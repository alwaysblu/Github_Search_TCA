//
//  SearchState.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import Foundation
import ComposableArchitecture

struct SearchState: Equatable {
    var showSignInView = false
    var isLoggedIn = false
    @BindableState var searchQuery = ""
    var searchedResults: IdentifiedArrayOf<SearchCellState> = []
    var code = ""
    var accessToken: AccessToken = .empty
    var countPerPage = 50
    var githubSignInURL: URL
    var pagination: Pagination = .empty
    var loginButtonText = "Login"
}


