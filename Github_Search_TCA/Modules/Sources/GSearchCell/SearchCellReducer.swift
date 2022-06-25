//
//  SearchCellReducer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation
import GCommon
import ComposableArchitecture

public let searchCellReducer =
Reducer<SearchCellState,
        SearchCellAction,
        SearchCellEnvironment> {
          state, action, environment in
          switch action {
          case .requestUserDetailInformation:
            guard state.userDetailInformation == .empty else {
              return .none
            }

            return environment.githubRepository
              .requestGithubUserDetailInformation(
                userName: state.userName,
                accessToken: state.accessToken.accessToken
              )
              .receive(on: environment.mainQueue)
              .catchToEffect(SearchCellAction.userDetailInformationResponse)

          case .userDetailInformationResponse(.success(let response)):
            state.userDetailInformation = response
            return .none

          case .userDetailInformationResponse(.failure(_)):
            return .none
          }
        }


