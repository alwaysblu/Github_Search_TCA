//
//  File.swift
//  
//
//  Created by 최정민 on 2022/06/29.
//

import Foundation
import GSearchCell
import GSearchMain

#if DEBUG
extension SearchCellState {
  static let empty = SearchCellState(
    imageUrl: "",
    userName: "",
    id: nil,
    userDetailInformation: .empty,
    isUserDataExist: false,
    accessToken: .empty
  )
}

extension SearchState {
  static let empty = SearchState(
    showSignInView: false,
    isLoggedIn: false,
    searchQuery: "",
    searchedResults: [],
    code: "",
    accessToken: .empty,
    countPerPage: 0,
    githubSignInURL: URL(fileURLWithPath: ""),
    pagination: .empty,
    loginButtonText: ""
  )
}
#endif
