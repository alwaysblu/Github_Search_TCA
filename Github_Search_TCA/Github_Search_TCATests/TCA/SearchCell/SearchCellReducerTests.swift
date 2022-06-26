//
//  SearchCellReducerTests.swift
//  Github_Search_TCATests
//
//  Created by 맥북 on 2022/06/11.
//

import XCTest
import ComposableArchitecture
@testable import Github_Search_TCA

class SearchCellReducerTests: XCTestCase {

  func test_requestUserDetailInformation_when데이터패치가성공하는경우_thenUserDetailInformation은empty가아니다() {
    //given
    let expectation = expectation(description: "UserDetailInformation Request Success")
    var state: SearchCellState = .empty
    let mockGithubRepository = MockGithubRepository.success
    let mockSearchCellEnviroment = SearchCellEnvironment(githubRepository: mockGithubRepository,
                                                         mainQueue: .main)
    var nextAction: SearchCellAction!

    //when
    let cancellable = searchCellReducer(&state,
                                        .requestUserDetailInformation,
                                        mockSearchCellEnviroment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(action, .userDetailInformationResponse(.success(MockGithubRepository.userDetailInformation)))
      nextAction = action
    })

    waitForExpectations(timeout: 5, handler: nil) // 스케줄링 고려해서 테스트하기

    _ = searchCellReducer(&state,
                          nextAction,
                          mockSearchCellEnviroment)

    //then
    XCTAssertNotEqual(state.userDetailInformation, .empty)
    cancellable.cancel()
  }

  func test_requestUserDetailInformation_when데이터패치가실패하는경우_thenUserDetailInformation은empty이다() {
    //given
    let expectation = expectation(description: "UserDetailInformation Request Fail")
    var state: SearchCellState = .empty
    let mockGithubRepository = MockGithubRepository.fail
    let mockSearchCellEnviroment = SearchCellEnvironment(githubRepository: mockGithubRepository,
                                                         mainQueue: .main)
    var nextAction: SearchCellAction!

    //when
    let cancellable = searchCellReducer(&state,
                                        .requestUserDetailInformation,
                                        mockSearchCellEnviroment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(action, .userDetailInformationResponse(.failure(TestError.network)))
      nextAction = action
    })

    waitForExpectations(timeout: 5, handler: nil) // 스케줄링 고려해서 테스트하기

    _ = searchCellReducer(&state,
                          nextAction,
                          mockSearchCellEnviroment)

    //then
    XCTAssertEqual(state.userDetailInformation, .empty)
    cancellable.cancel()
  }
}
