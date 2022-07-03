//
//  ReducerUsersInformationSpec.swift
//  
//
//  Created by 최정민 on 2022/07/03.
//

import ComposableArchitecture
import Combine
import Nimble
import Quick

@testable import GSearchCell
@testable import GSearchMain
@testable import GRepositories
@testable import TestSupport

final class UsersInformationSpec: QuickSpec {

  override func spec() {
    var state: SearchState!
    var mockSearchEnvironment: SearchEnvironment!

    describe("searchBar에 입력된 query에 대한 UsersInformation을 요청한다.") {
      context("AccessToken이 없는 경우") {
        beforeEach { // Arrange
          state  = .empty
          state.searchQuery = "test"
          state.accessToken = .empty
          mockSearchEnvironment = SearchEnvironment(
            githubRepository: MockGitRepository.success,
            mainQueue: .main,
            cellEnvironment: .mock
          )
        }

        it("receiveValue가 호출되지 않는다.") {
          // Act
          _ = searchReducer(
            &state,
            .binding(
              BindingAction.set(
                \SearchState.$searchQuery,
                 state.searchQuery
              )
            ),
            mockSearchEnvironment
          )
          .sink(
            receiveCompletion: { _ in},
            receiveValue: { action in
              // Assert
              fail("access token이 없으므로 호출되면 안된다.")
            }
          )
        }
      }

      context("AccessToken이 있는 경우") {
        context("UsersInformation 요청 성공하는 경우") {
          beforeEach { // Arrange
            state  = .empty
            state.searchQuery = "test"
            state.accessToken = MockGithubRepository.accessToken
            mockSearchEnvironment = SearchEnvironment(
              githubRepository: MockGitRepository.success,
              mainQueue: .main,
              cellEnvironment: .mock
            )
          }

          it("receiveValue의 action이 githubUsersInformationResponse success이다.") {
            // Act
            _ = searchReducer(
              &state,
              .binding(
                BindingAction.set(
                  \SearchState.$searchQuery,
                   state.searchQuery
                )
              ),
              mockSearchEnvironment
            )
            .sink(
              receiveCompletion: { _ in},
              receiveValue: { action in
                // Assert
                switch action {
                case .githubUsersInformationResponse(let result):
                  switch result {
                  case .success(let response):
                    expect(response)
                      .to(
                        equal(
                          MockGitRepository.userInformationPage
                        )
                      )
                  case .failure(_):
                    fail("기대와 다른 result")
                  }
                default:
                  fail("기대와 다른 action")
                }
              }
            )
          }

          it("state pagination은 empty가 아니고 searchedResults는 []이 아니다.") {
            // Act
            _ = searchReducer(
              &state,
              .githubUsersInformationResponse(
                .success(MockGitRepository.userInformationPage)
              ),
              mockSearchEnvironment
            )
            // Assert
            expect(
              (state.pagination, state.searchedResults)
            ).notTo(
              equal(
                (.empty, [])
              )
            )
          }
        }

        context("UsersInformation 요청 실패하는 경우") {
          beforeEach { // Arrange
            state  = .empty
            mockSearchEnvironment = SearchEnvironment(
              githubRepository: MockGitRepository.fail,
              mainQueue: .main,
              cellEnvironment: .mock
            )
          }

          it("receiveValue의 action이 githubUsersInformationResponse fail이다.") {
            // Act
            _ = searchReducer(
              &state,
              .binding(
                BindingAction.set(
                  \SearchState.$searchQuery,
                   state.searchQuery
                )
              ),
              mockSearchEnvironment
            )
            .sink(
              receiveCompletion: { _ in},
              receiveValue: { action in
                // Assert
                switch action {
                case .githubUsersInformationResponse(let result):
                  switch result {
                  case .success(_):
                    fail("기대와 다른 result")

                  case .failure(let error):
                    expect(error)
                      .to(
                        beAKindOf(TestError.self)
                      )
                  }
                default:
                  fail("기대와 다른 action")
                }
              }
            )
          }

          it("state pagination은 empty이고 searchedResults는 []이다.") {
            // Act
            _ = searchReducer(
              &state,
              .githubUsersInformationResponse(
                .failure(TestError.network)
              ),
              mockSearchEnvironment
            )
            // Assert
            expect(
              (state.pagination, state.searchedResults)
            ).to(
              equal(
                (.empty, [])
              )
            )
          }
        }
      }
    }
  }
}

