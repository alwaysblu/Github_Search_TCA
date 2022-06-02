//
//  SearchState.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation
import ComposableArchitecture

struct SearchState: Equatable {
    var showSignInView = false
    var isLoggedIn = false
    @BindableState
    var searchQuery = ""
    var searchedResults: IdentifiedArrayOf<SearchCellState> = []
    var code = ""
    var accessToken: AccessToken = .empty
    var countPerPage = 50
    var githubSignInURL: URL?
    var isLastResult = false
    var isFirstResult = false
    var nextUrl = ""
    var loginButtonText = "Login"
}
