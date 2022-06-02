//
//  SearchReducer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI
import ComposableArchitecture
// reducer는 그냥 함수이지 lazy와 관련된 것이 아니라 lazy는 플랫폼에 관련된 것이다.
let searchReducer =
Reducer<SearchState,
        SearchAction,
        SearchEnvironment>.combine( // 120줄 정도로 작성하기
            searchCellReducer.forEach( // lazy하다(collectionView의 reusable이랑 비슷한 개념) 복잡도가 있거나 api를 여러번 불러야할 때 사용하면 좋다.
                state: \.searchedResults,
                action: /SearchAction.searchCellResult(id:action:),
                environment: { $0.cellEnvironment }
                                     ),
            Reducer { state, action, environment in
                switch action {
                case .githubUsersInformationResponse(.success((let response, let urlResponse))):
                    let receivedData = response // 깃허브에서 페이지네이션 정보를 사용해서 combine을 사용해서 구현해볼 것!
                        .informations// 페이지네이션 정보를 받아와서 페이지네이션을 구현해볼 것
                        .map {
                            SearchCellState(imageUrl: $0.profileUrl,
                                            userName: $0.userName,
                                            id: UUID(),
                                            detail: SearchDetailViewState(userDetailInformation: environment.emptyUserDetailInformation,
                                                                          userName: $0.userName
                                                                         ),
                                            accessToken: state.accessToken
                            )
                        }
                    let links: [LinkHeader] = environment
                        .linkHandler
                        .getLinks(response: urlResponse)
                    
                    state.nextUrl = environment
                        .linkHandler
                        .getNextUrl(links: links)
                    state.isFirstResult = environment
                        .linkHandler
                        .getIsFirstResult(links: links)
                    state.isLastResult = environment
                        .linkHandler
                        .getIsLastResult(links: links)
                    
                    state.searchedResults = state.isFirstResult
                    ? IdentifiedArrayOf(uniqueElements: receivedData)
                    : IdentifiedArrayOf(uniqueElements: state.searchedResults + receivedData)
                    
                    return .none
                    
                case .githubUsersInformationResponse(.failure(_)):
                    return .none
                    
                case .fetchUsers:
                    return environment.githubRepository
                        .fetchGithubUsers(next: state.nextUrl,
                                          accessToken:  state.accessToken.accessToken
                        )
                        .receive(on: environment.mainQueue)
                        .catchToEffect(SearchAction.githubUsersInformationResponse)
                    
                case .showSignInView:
                    state.showSignInView.toggle()
                    
                    return .none
                    
                case .requestAccessToken:
                    guard state.code != "" else { return .none }
                    
                    return environment.githubRepository
                        .requestAccessToken(code: state.code)
                        .receive(on: environment.mainQueue)
                        .catchToEffect(SearchAction.accessTokenResponse)
                    
                case .responseCode(let url):
                    guard let url = URLComponents(string: url.absoluteString), // 리듀서로 전부 넣어주어야함
                          let code = url.queryItems?.first(where: { $0.name == "code" })?.value else {
                              return .none
                          } // 리듀서로 전부 넣어주어야함
                    state.code = code
                    state.loginButtonText = "Already Logged In"
                    return .none
                    
                case .accessTokenResponse(.success(let response)):
                    state.accessToken = response
                    
                    return .none
                    
                case .accessTokenResponse(.failure(_)):
                    return .none
                    
                case .searchCellResult(id: let id, action: let action):
                    return .none
                    
                case .binding(\.$searchQuery):
                    guard state.accessToken.accessToken != "" else { return .none }
                    state.isLastResult = false
                    struct CancelDelayId: Hashable {}
                    state.searchedResults = []
                    
                    return environment.githubRepository
                        .fetchGithubUsers(query: state.searchQuery,
                                          page: 1,
                                          countPerPage: state.countPerPage,
                                          accessToken: state.accessToken.accessToken
                        )
                        .receive(on: environment.mainQueue)
                        .catchToEffect(SearchAction.githubUsersInformationResponse)
                        .debounce(id: CancelDelayId(),
                                  for: 1,
                                  scheduler: environment.mainQueue
                        )
                    
                case .binding:
                    return .none
                }
            }
        )
    .binding()
    .debug()






