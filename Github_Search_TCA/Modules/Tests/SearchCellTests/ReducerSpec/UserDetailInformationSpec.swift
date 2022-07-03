//
//  ReducerUserDetailInformationSpec.swift
//  
//
//  Created by 최정민 on 2022/06/30.
//

import ComposableArchitecture
import Combine
import Nimble
import Quick

@testable import GSearchCell
@testable import GRepositories
@testable import TestSupport

final class UserDetailInformationSpec: QuickSpec {

  override func spec() {
    var state: SearchCellState!
    var mockSearchCellEnviroment: SearchCellEnvironment!

    describe("UserDetailInformation을 요청한다.") { // given
      context("데이터 요청이 성공하는 경우") { // when
        beforeEach { // Arrange
          state  = .empty
          mockSearchCellEnviroment = SearchCellEnvironment(
            githubRepository:  MockGitRepository.success,
            mainQueue: .main
          )
        }

        it("receiveValue의 action이 userDetailInformationResponse success이다.") { // then
          // Act
          _ = searchCellReducer(
            &state,
            .requestUserDetailInformation,
            mockSearchCellEnviroment
          )
          .sink(
            receiveCompletion: { _ in },
            receiveValue: { action in

              // Assert
              expect(action)
                .to(
                  equal(
                    .userDetailInformationResponse(
                      .success(MockGitRepository.userDetailInformationResponseDTO)
                    )
                  )
                )
            }
          )
        }

        it("state의 userDetailInformation은 empty가 아니어야 한다") { // then
          // Act
          _ = searchCellReducer(
            &state,
            .userDetailInformationResponse(
              .success(MockGitRepository.userDetailInformationResponseDTO)
            ),
            mockSearchCellEnviroment
          )

          // Assert
          expect(state.userDetailInformation)
            .notTo(
              equal(.empty)
            )
        }
      }

      context("데이터 요청이 실패하는 경우") { // when
        beforeEach { // Arrange
          state  = .empty
          mockSearchCellEnviroment = SearchCellEnvironment(
            githubRepository: MockGitRepository.fail,
            mainQueue: .main
          )
        }

        it("receiveValue의 action이 userDetailInformationResponse(failure(TestError.network))이다.") { // then
          // Act
          _ = searchCellReducer(
            &state,
            .requestUserDetailInformation,
            mockSearchCellEnviroment
          )
          .sink(
            receiveCompletion: { _ in},
            receiveValue: { action in

              // Assert
              expect(action)
                .to(
                  equal(
                    .userDetailInformationResponse(
                      .failure(TestError.network)
                    )
                  )
                )
            }
          )
        }

        it("state의 userDetailInformation은 empty이어야 한다") { // then
          // Act
          _ = searchCellReducer(
            &state,
            .userDetailInformationResponse(.failure(TestError.network)),
            mockSearchCellEnviroment
          )

          // Assert
          expect(state.userDetailInformation)
            .to(
              equal(.empty)
            )
        }
      }
    }
  }
}
