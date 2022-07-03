//
//  ReducerAccessTokenSpec.swift
//  
//
//  Created by 최정민 on 2022/07/02.
//

import ComposableArchitecture
import Combine
import Nimble
import Quick

@testable import GSearchCell
@testable import GSearchMain
@testable import GRepositories
@testable import TestSupport

final class AccessTokenSpec: QuickSpec {
  
  override func spec() {
    var state: SearchState!
    var mockSearchEnvironment: SearchEnvironment!
    
    describe("access token을 요청한다.") {
      context("code가 없는 경우") {
        it("receiveValue 클로저가 작동하면 안된다.") {
          // Arrange
          state = .empty
          state.code = ""
          mockSearchEnvironment = SearchEnvironment(
            githubRepository: MockGitRepository.success,
            mainQueue: .main,
            cellEnvironment: .mock
          )
          // Act
          _ = searchReducer(
            &state,
            .requestAccessToken,
            mockSearchEnvironment
          )
          .sink(
            receiveCompletion: { _ in},
            receiveValue: { action in
              // Assert
              fail("엑세스 토큰이 없는 경우에는 호출되면 안된다.")
            }
          )
        }
      }

      context("code가 있는 경우") {
        context("access token 요청이 성공하는 경우") {
          beforeEach { // Arrange
            state  = .empty
            state.code = "test"
            mockSearchEnvironment = SearchEnvironment(
              githubRepository: MockGitRepository.success,
              mainQueue: .main,
              cellEnvironment: .mock
            )
          }

          it("receiveValue의 action이 accessTokenResponse success이다.") {
            // Act
            _ = searchReducer(
              &state,
              .requestAccessToken,
              mockSearchEnvironment
            )
            .sink(
              receiveCompletion: { _ in},
              receiveValue: { action in
                // Assert
                switch action {
                case .accessTokenResponse(let result):
                  switch result {
                  case .success(let response):
                    expect(response)
                      .to(
                        equal(
                          MockGitRepository.accessTokenResponseDTO
                        )
                      )
                  case .failure(_):
                    fail("기대와 다른 result")
                  }
                default:
                  fail("기대와 다른 액션")
                }
              }
            )
          }

          it("state의 accessToken은 empty가 아니다.") {
            // Act
            _ = searchReducer(
              &state,
              .accessTokenResponse(.success(MockGitRepository.accessTokenResponseDTO)),
              mockSearchEnvironment
            )
            // Assert
            expect(state.accessToken)
              .notTo(
                equal(
                  .empty
                )
              )
          }
        }

        context("access token 요청이 실패하는 경우 ") {
          beforeEach { // Arrange
            state  = .empty
            state.code = "test"
            mockSearchEnvironment = SearchEnvironment(
              githubRepository: MockGitRepository.fail,
              mainQueue: .main,
              cellEnvironment: .mock
            )
          }

          it("receiveValue의 action이 accessTokenResponse success이다.") {
            // Act
            _ = searchReducer(
              &state,
              .requestAccessToken,
              mockSearchEnvironment
            )
            .sink(
              receiveCompletion: { _ in},
              receiveValue: { action in
                switch action {
                case .accessTokenResponse(let result):
                  switch result {
                  case .success(_):
                    fail("기대와 다른 result")
                  case .failure(let error):
                    // Assert
                    expect(error)
                      .to(
                        beAKindOf(TestError.self)
                      )
                  }
                default:
                  fail("기대와 다른 액션")
                }
              }
            )
          }

          it("state의 accessToken은 empty이다.") {
            // Act
            _ = searchReducer(
              &state,
              .accessTokenResponse(.failure(TestError.network)),
              mockSearchEnvironment
            )
            //Assert
            expect(state.accessToken)
              .to(
                equal(
                  .empty
                )
              )
          }
        }
      }
    }
  }
}
