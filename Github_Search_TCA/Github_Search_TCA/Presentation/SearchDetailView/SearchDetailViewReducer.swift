//
//  SearchDetailViewReducer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation
import ComposableArchitecture

let searchDetailViewReducer =
Reducer<SearchDetailViewState,
        SearchDetailViewAction,
        SearchDetailViewEnvironment> { state, action, environment in
            switch action {
            case .requestUserDetailInformation:
                return environment.githubRepository
                    .requestGithubUserDetailInformation(userName: state.userName,
                                                        accessToken: state.accessToken.accessToken)
                    .receive(on: environment.mainQueue)
                    .catchToEffect(SearchDetailViewAction.userDetailInformationResponse)
                
            case .userDetailInformationResponse(.success(let response)):
                state.userDetailInformation = response
                
                return .none
                
            case .userDetailInformationResponse(.failure(_)):
                return .none
            }
        }
