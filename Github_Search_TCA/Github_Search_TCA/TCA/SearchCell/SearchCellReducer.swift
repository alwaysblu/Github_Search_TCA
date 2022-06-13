//
//  SearchCellReducer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation
import ComposableArchitecture

let searchCellReducer =
Reducer<SearchCellState,
        SearchCellAction,
        SearchCellEnvironment> {
            state, action, environment in
            switch action {
            case .requestUserDetailInformation:
                guard state.userDetailInformation == .empty else {
                    return .none
                }
                
//                return current.searchCellEffectContainer
//                    .requestUserDetailInformation(state.userName,
//                                                  state.accessToken.accessToken,
//                                                  .main)
                
                return environment.githubRepository
                    .requestGithubUserDetailInformation(userName: state.userName,
                                                        accessToken: state.accessToken.accessToken)
                    .receive(on: environment.mainQueue)
                    .catchToEffect(SearchCellAction.userDetailInformationResponse)
                
            case .userDetailInformationResponse(.success(let response)):
                state.userDetailInformation = response
                
                return .none
                
            case .userDetailInformationResponse(.failure(_)):
                return .none
            }
        }


//private var current = SearchCellEnvironment.live
//
//struct SearchCellEnvironment {
//    let searchCellEffectContainer: SearchCellEffectContainer
//}
//
//extension SearchCellEnvironment {
//    static let live = SearchCellEnvironment(searchCellEffectContainer: .live)
//}
//
//struct SearchCellEffectContainer {
//    var requestUserDetailInformation: (String, String, AnySchedulerOf<DispatchQueue>) -> Effect<SearchCellAction, Never>
//}
//
//extension SearchCellEffectContainer {
//    static let live = SearchCellEffectContainer(requestUserDetailInformation: { userName, accessToken, scheduler in
//        return DIContainer.makeGithubRepository()
//            .requestGithubUserDetailInformation(userName: userName,
//                                                accessToken: accessToken)
//            .receive(on: scheduler)
//            .catchToEffect(SearchCellAction.userDetailInformationResponse)
//    })
//}
