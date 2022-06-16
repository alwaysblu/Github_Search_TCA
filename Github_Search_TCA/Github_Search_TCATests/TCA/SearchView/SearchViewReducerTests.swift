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
    var state: SearchState = .empty
    let mockGithubRepository = MockGithubRepository.success
    let mockSearchCellEnviroment = SearchCellEnvironment(githubRepository: mockGithubRepository,
                                                         mainQueue: .main)
    let mockSearchEnvironment = SearchEnvironment(githubRepository: mockGithubRepository,
                                                  mainQueue: .main,
                                                  cellEnvironment: mockSearchCellEnviroment
    )
    var nextAction: SearchAction!
    state.code = "test" // github로 부터 code를 전달받아야 accessToken을 요청한다.

    //when
    let cancellable = searchReducer(&state,
                                    .requestAccessToken,
                                    mockSearchEnvironment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(action, .accessTokenResponse(.success(MockGithubRepository.accessToken)))
      nextAction = action
    })

    waitForExpectations(timeout: 5, handler: nil) // 스케줄링 고려해서 테스트하기

    _ = searchReducer(&state,
                      nextAction,
                      mockSearchEnvironment)

    //then
    XCTAssertNotEqual(state.accessToken, .empty)
    cancellable.cancel()
  }

  func test_requestAccessToken_whenAccessToken을실패하는경우_thenState의AccessToken이empty이다() {
    //given
    let expectation = expectation(description: "AccessToken Request Fail")
    var state: SearchState = .empty
    let mockGithubRepository = MockGithubRepository.fail
    let mockSearchCellEnviroment = SearchCellEnvironment(githubRepository: mockGithubRepository,
                                                         mainQueue: .main
    )
    let mockSearchEnvironment = SearchEnvironment(githubRepository: mockGithubRepository,
                                                  mainQueue: .main,
                                                  cellEnvironment: mockSearchCellEnviroment
    )
    var nextAction: SearchAction!
    state.code = "test" // github로 부터 code를 전달받아야 accessToken을 요청한다.

    //when
    let cancellable = searchReducer(&state,
                                    .requestAccessToken,
                                    mockSearchEnvironment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(action, .accessTokenResponse(.failure(TestError.network)))
      nextAction = action
    })

    waitForExpectations(timeout: 5, handler: nil) // 스케줄링 고려해서 테스트하기

    _ = searchReducer(&state,
                      nextAction,
                      mockSearchEnvironment)

    //then
    XCTAssertEqual(state.accessToken, .empty)
    cancellable.cancel()
  }
}
