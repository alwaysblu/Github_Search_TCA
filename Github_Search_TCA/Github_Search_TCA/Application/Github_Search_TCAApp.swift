//
//  Github_Search_TCAApp.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct Github_Search_TCAApp: App {
    private let store: Store<SearchState, SearchAction>
    @ObservedObject
    private var viewStore: ViewStore<SearchState, SearchAction>
    
    init() {
        store = DIContainer.makeSearchStore()
        viewStore = ViewStore(store)
    }
    
    var body: some Scene {
        WindowGroup {
            SearchView(store: store)
                .onOpenURL { (url) in
                    viewStore.send(.handleResponse(url))
                }
        }
    }
}
