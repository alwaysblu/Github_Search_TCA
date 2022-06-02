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
        SearchCellEnvironment> .combine(
            searchDetailViewReducer.pullback(state: \.detail,
                                             action: /SearchCellAction.detail,
                                             environment: { $0.detailViewEnvironment }),
            Reducer {
                state, action, environment in
                switch action {
                case .detail(_):
                    return .none
                    
                case .requestUserDetailInformation(_):
                    guard state.detail.userDetailInformation.followers == 0 else { return .none }
                    
                    return environment.githubRepository
                        .requestGithubUserDetailInformation(userName: state.userName,
                                                            accessToken: state.accessToken.accessToken)
                        .receive(on: environment.mainQueue)
                        .catchToEffect(SearchCellAction.userDetailInformationResponse)
                    
                case .userDetailInformationResponse(.success(let response)):
                    state.detail.userDetailInformation = response
                    state.detail.accessToken = state.accessToken
                    
                    return .none
                    
                case .userDetailInformationResponse(.failure(_)):
                    return .none
                }
            }
        )
