//
//  SearchReducer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI
import ComposableArchitecture

let searchReducer =
Reducer<SearchState,
        SearchAction,
        SearchEnvironment>.combine(
            searchCellReducer.forEach(
                state: \.searchedResults,
                action: /SearchAction.searchCellResult(id:action:),
                environment: { $0.cellEnvironment }
                                     ),
            Reducer { state, action, environment in
                switch action {
                case .githubUsersInformationResponse(.success((let response, let urlResponse))):
                    let receivedData = response
                        .informations
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
                    guard let url = URLComponents(string: url.absoluteString),
                          let code = url.queryItems?.first(where: { $0.name == "code" })?.value else {
                              return .none
                          } 
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






