//
//  SearchDetailViewReducer.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation
import ComposableArchitecture

let searchDetailViewReducer = Reducer<SearchDetailViewState, SearchDetailViewAction, SearchDetailViewEnvironment> { state, action, environment in
    switch action {
    case .requestUserDetailInformation:
        return environment.githubRepository
            .requestGithubUserDetailInformation(userName: state.userName)
            .receive(on: environment.mainQueue)
            .catchToEffect(SearchDetailViewAction.userDetailInformationResponse)
    case .userDetailInformationResponse(let response):
        switch response {
        case .success(let result):
            state.userDetailInformation = result
        case .failure(let error):
            "\(error)".log("searchDetailViewReducer/userDetailInformationResponse")
        }
        
        return .none
    }
}
