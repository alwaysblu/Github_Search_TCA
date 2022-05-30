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
    var searchQuery = ""
    var totalPage = 0
    var currentPage = 1
    var searchedResults: IdentifiedArrayOf<SearchCellState> = []
    var code = ""
    var accessToken = AccessToken(accessToken: "", tokenType: "", scope: "")
    var countPerPage = 50
}
