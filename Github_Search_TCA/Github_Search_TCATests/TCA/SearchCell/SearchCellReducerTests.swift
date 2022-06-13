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
    
    struct MockGithubRepository: GithubRepository {
        let mockUserInformationPage = UserInformationPage(totalCount: 0,
                                                          informations: [],
                                                          pagination: .empty)
        let mockUserDetailInformation = UserDetailInformation(profileImage: "test",
                                                              githubUrl: "test",
                                                              followersUrl: "test",
                                                              followingUrl: "test",
                                                              gistsUrl: "test",
                                                              starredUrl: "test",
                                                              subscriptionsUrl: "test",
                                                              organizationsUrl: "test",
                                                              reposUrl: "test",
                                                              eventsUrl: "test",
                                                              receivedEventsUrl: "test",
                                                              type: "test",
                                                              name: "test",
                                                              company: "test",
                                                              blog: "test",
                                                              location: "test",
                                                              email: "test",
                                                              bio: "test",
                                                              twitterUsername: "test",
                                                              publicRepos: 9,
                                                              publicGists: 9,
                                                              followers: 9,
                                                              following: 9)
        
        func fetchGithubUsers(query: String?, page: Int?, countPerPage: Int?, next: String?, accessToken: String) -> Effect<UserInformationPage, Error> {
            return Effect.task {
                return mockUserInformationPage
            }
        }
        
        func requestGithubUserDetailInformation(userName: String, accessToken: String) -> Effect<UserDetailInformation, Error> {
            return Effect.task {
                return mockUserDetailInformation
            }
        }
        
        func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
            return Effect.task {
                return AccessToken.empty
            }
        }
        
        
    }
    
    func test_requestUserDetailInformation_when테스트성공하는경우_then() {
        //given
        let expectation = self.expectation(description: "Search Success")
        var state = SearchCellState(imageUrl: "",
                                    userName: "cjmin",
                                    id: UUID(),
                                    userDetailInformation: .empty,
                                    isUserDataExist: false,
                                    accessToken: .empty)
        let mockSearchCellEnviroment = SearchCellEnvironment(githubRepository: MockGithubRepository(),
                                                             mainQueue: .main)
        let mockGithubRepository = MockGithubRepository()
        var nextAction: SearchCellAction!
        
        //when
        var effects = searchCellReducer(&state,
                                        .requestUserDetailInformation,
                                        mockSearchCellEnviroment
        ).sink(receiveCompletion: { _ in
            expectation.fulfill()
        },
               receiveValue: { action in
            XCTAssertEqual(action, .userDetailInformationResponse(.success(mockGithubRepository.mockUserDetailInformation)))
            nextAction = action
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        _ = searchCellReducer(&state,
                          nextAction,
                          mockSearchCellEnviroment)
        
        //then
        
        XCTAssertNotEqual(state.userDetailInformation, .empty)
    }
}
