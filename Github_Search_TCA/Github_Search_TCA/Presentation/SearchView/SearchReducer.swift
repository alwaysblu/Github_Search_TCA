//
//  SearchReducer.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

let searchReducer = Reducer<SearchState, SearchAction, SearchEnvironment>.combine(
    searchCellReducer.forEach(state: \.searchedResults,
                              action: /SearchAction.searchCellResult(id:action:),
                              environment: { _ in SearchCellEnvironment() }),
    Reducer { state, action, environment in
        switch action {
        case .searchQueryChanged(let searchQuery):
            struct CancelDelayId: Hashable {}
            state.searchQuery = searchQuery
            state.searchedResults = []
            
            return environment.githubRepository
                .fetchGithubUsers(query: searchQuery, page: 1, countPerPage: state.countPerPage)
                .receive(on: environment.mainQueue)
                .catchToEffect(SearchAction.githubUsersInformationResponse)
                .debounce(id: CancelDelayId(), for: 1, scheduler: RunLoop.main)
            
        case .githubUsersInformationResponse(.success(let response)):
            let receivedData = response.informations.map { SearchCellState(imageUrl: $0.profileUrl,
                                                                           userName: $0.userName,
                                                                           id: UUID(),
                                                                           detail: SearchDetailViewState(userDetailInformation: UserDetailInformation.empty,
                                                                                                         userName: $0.userName)) }
            state.searchedResults = state.currentPage == 1 ? IdentifiedArrayOf(uniqueElements: receivedData) : IdentifiedArrayOf(uniqueElements: state.searchedResults + receivedData)
            state.totalPage = response.totalCount/state.countPerPage + 1
            
            return .none
            
        case .githubUsersInformationResponse(.failure(let error)):
            "\(error)".log("searchReducer/githubUsersInformationResponse")
            
            return .none
            
        case .fetchUsers:
            state.currentPage = state.totalPage > state.currentPage ? state.currentPage + 1 : state.totalPage
            
            return environment.githubRepository
                .fetchGithubUsers(query: state.searchQuery, page: state.currentPage, countPerPage: state.countPerPage)
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
            
        case .responseCode(let code):
            state.code = code
            
            return .none
            
        case .accessTokenResponse(let result):
            switch result {
            case .success(let response) :
                state.accessToken = response
            case .failure(let error) :
                "\(error)".log("searchReducer/accessTokenResponse")
            }
            
            return .none
        case .searchCellResult(id: let id, action: let action):
            return .none
        }
    }
)
