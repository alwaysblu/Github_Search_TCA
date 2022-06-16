//
//  +Extension.swift
//  Github_Search_TCATests
//
//  Created by 맥북 on 2022/06/15.
//

import Foundation

#if DEBUG
extension SearchCellState {
  static let empty = SearchCellState(imageUrl: "",
                                     userName: "",
                                     id: nil,
                                     userDetailInformation: .empty,
                                     isUserDataExist: false,
                                     accessToken: .empty)
}
#endif

#if DEBUG
extension SearchState {
  static let empty = SearchState(showSignInView: false,
                                 isLoggedIn: false,
                                 searchQuery: "",
                                 searchedResults: [],
                                 code: "",
                                 accessToken: .empty,
                                 countPerPage: 0,
                                 githubSignInURL: URL(fileURLWithPath: ""),
                                 pagination: .empty,
                                 loginButtonText: "")
}
#endif
