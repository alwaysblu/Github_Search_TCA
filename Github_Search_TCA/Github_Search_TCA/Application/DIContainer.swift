//
//  DIContainer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/06/09.
//

import Foundation
import ComposableArchitecture

enum DIContainer {
    static func makeGithubRepository() -> GithubRepository {
        return DefaultGithubRepository(networkManager: makeNetworkManager())
    }
    
    static func makeNetworkManager() -> NetworkManager {
        return DefaultNetworkManager(networkLoader: makeNetworkLoader())
    }
    
    static func makeNetworkLoader() -> NetworkLoader {
        return DefaultNetworkLoader(session: .shared)
    }
    
    static func makeSearchCellEnvironment() -> SearchCellEnvironment {
        return SearchCellEnvironment(githubRepository: makeGithubRepository(), mainQueue: .main)
    }
    
    static func makeSearchEnvironment() -> SearchEnvironment {
        return SearchEnvironment(githubRepository: makeGithubRepository(),
                                 mainQueue: .main,
                                 cellEnvironment: makeSearchCellEnvironment(),
                                 emptyUserDetailInformation: .empty
        )
    }
    
    static func makeSearchState() -> SearchState {
        return SearchState(githubSignInURL: APIURL.getGithubSignInURL())
    }
    
    static func makeSearchStore() -> Store<SearchState, SearchAction> {
        return Store(initialState: makeSearchState(),
                     reducer: searchReducer,
                     environment: makeSearchEnvironment()
        )
    }
}
