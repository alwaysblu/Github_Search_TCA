
import ComposableArchitecture
import XCTest

@testable import GSearchCell
@testable import GRepositories
@testable import TestSupport

final class SearchCellReducerTests: XCTestCase {

  func test_requestUserDetailInformation_when데이터패치가성공하는경우_thenUserDetailInformation은empty가아니다() {
    //given
    let expectation = expectation(description: "UserDetailInformation Request Success")
    var state: SearchCellState = .empty
    let mockGitRepository = MockGitRepository.success
    let mockSearchCellEnviroment = SearchCellEnvironment(
      githubRepository: mockGitRepository,
      mainQueue: .main
    )
    var nextAction: SearchCellAction!

    //when
    let cancellable = searchCellReducer(
      &state,
      .requestUserDetailInformation,
      mockSearchCellEnviroment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(
        action,
        .userDetailInformationResponse(.success(MockGitRepository.userDetailInformationResponseDTO))
      )
      nextAction = action
    })

    waitForExpectations(
      timeout: 5,
      handler: nil
    ) // 스케줄링 고려해서 테스트하기

    _ = searchCellReducer(
      &state,
      nextAction,
      mockSearchCellEnviroment
    )

    //then
    XCTAssertNotEqual(state.userDetailInformation, .empty)
    cancellable.cancel()
  }

  func test_requestUserDetailInformation_when데이터패치가실패하는경우_thenUserDetailInformation은empty이다() {
    //given
    let expectation = expectation(description: "UserDetailInformation Request Fail")
    var state: SearchCellState = .empty
    let mockGitRepository = MockGitRepository.fail
    let mockSearchCellEnviroment = SearchCellEnvironment(
      githubRepository: mockGitRepository,
      mainQueue: .main
    )
    var nextAction: SearchCellAction!

    //when
    let cancellable = searchCellReducer(
      &state,
      .requestUserDetailInformation,
      mockSearchCellEnviroment
    ).sink(receiveCompletion: { _ in
      expectation.fulfill()
    }, receiveValue: { action in
      XCTAssertEqual(
        action,
        .userDetailInformationResponse(.failure(TestError.network))
      )
      nextAction = action
    })

    waitForExpectations(
      timeout: 5,
      handler: nil
    ) // 스케줄링 고려해서 테스트하기

    _ = searchCellReducer(
      &state,
      nextAction,
      mockSearchCellEnviroment
    )

    //then
    XCTAssertEqual(
      state.userDetailInformation,
      .empty
    )
    cancellable.cancel()
  }
}
