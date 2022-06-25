//
//  Github_Search_TCAApp.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/24.
//

import SwiftUI
import GDIContainer

@main
struct Github_Search_TCAApp: App {
  let store: Store<SearchState, SearchAction>
  let viewStore: ViewStore<SearchState, SearchAction>

  init() {
    store = DIContainer.makeSearchStore()
    viewStore = DIContainer.makeSearchViewStore(store)
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
