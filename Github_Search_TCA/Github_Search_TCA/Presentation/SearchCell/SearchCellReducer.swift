//
//  SearchCellReducer.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation
import ComposableArchitecture

let searchCellReducer =
Reducer<SearchCellState, SearchCellAction, SearchCellEnvironment> .combine(
    searchDetailViewReducer.pullback(state: \.detail,
                                     action: /SearchCellAction.detail,
                                     environment: { _ in  SearchDetailViewEnvironment(mainQueue: .main)}),
    Reducer {
        state, action, environment in
        switch action {
        case .detail(_):
            return .none
        }
    }
)
