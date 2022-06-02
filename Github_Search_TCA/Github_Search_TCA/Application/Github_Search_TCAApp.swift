//
//  Github_Search_TCAApp.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct onboardingAppApp: App {
    private let store: Store<SearchState, SearchAction>
    @ObservedObject
    var viewStore: ViewStore<SearchState, SearchAction>
    
    init() {
        let networkManager = DefaultNetworkManager(networkLoader: DefaultNetworkLoader(session: .shared))
        store = Store(initialState: SearchState(githubSignInURL: APIURL.getGithubSignInURL()),
                      reducer: searchReducer,
                      environment: SearchEnvironment(githubRepository:
                                                        GithubRepository(networkManager: networkManager),
                                                     mainQueue: .main,
                                                     emptyUserDetailInformation: .empty
                                                    )
        )
        viewStore = ViewStore(store)
    }
    
    var body: some Scene {
        WindowGroup {
            SearchView(store: store)
                .onOpenURL { (url) in
                    viewStore.send(.responseCode(url))
                }
        }
    }
}
