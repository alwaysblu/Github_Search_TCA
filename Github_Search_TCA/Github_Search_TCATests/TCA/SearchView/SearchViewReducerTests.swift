//
//  SearchViewReducerTests.swift
//  Github_Search_TCATests
//
//  Created by 맥북 on 2022/06/11.
//

import XCTest
@testable import Github_Search_TCA

class SearchViewReducerTests: XCTestCase {

    func test_requestAccessToken_whenAccessToken을성공적으로받는경우_thenState의AccessToken이empty가아니다() {
        //given
        let expectation = expectation(description: "AccessToken Request Success")
        var state = SearchState(githubSignInURL: URL(fileURLWithPath: "test"))
        
        
    }
}
