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
                case .githubUsersInformationResponse(.success(let response)):
                    let receivedData = response
                        .informations
                        .map {
                            SearchCellState(imageUrl: $0.profileUrl,
                                            userName: $0.userName,
                                            id: UUID(),
                                            accessToken: state.accessToken
                            )
                        }
                    state.pagination = response.pagination
                    state.searchedResults = state.pagination.isFirst
                    ? IdentifiedArrayOf(uniqueElements: receivedData)
                    : IdentifiedArrayOf(uniqueElements: state.searchedResults + receivedData)
                    
                    return .none
                    
                case .githubUsersInformationResponse(.failure(_)):
                    return .none
                    
                case .fetchUsers:
                    return environment.githubRepository
                        .fetchGithubUsers(query: nil,
                                          page: nil,
                                          countPerPage: nil,
                                          next: state.pagination.nextUrl,
                                          accessToken: state.accessToken.accessToken)
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
                    
                case .handleResponse(let url):
                    guard let url = URLComponents(string: url.absoluteString) else {
                        return .none
                    }
                    
                    guard let code = url
                        .queryItems?
                        .first(where: { // 깃허브 url인지 아닌지 구별해야함
                            $0.name == "code"
                        })?
                        .value else {
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
                    state.pagination.isLast = false
                    struct CancelDelayId: Hashable {}
                    state.searchedResults = []
                    
                    return environment.githubRepository
                        .fetchGithubUsers(query: state.searchQuery,
                                          page: 1,
                                          countPerPage: state.countPerPage,
                                          next: nil,
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
                case .responseURL(let url):
                    switch url {
                        
                    }
                }
            }
        )
    .binding()
    .debug()






