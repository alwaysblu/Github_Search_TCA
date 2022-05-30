//
//  SearchDetailView.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

struct SearchDetailView: View {
    private let store: Store<SearchDetailViewState, SearchDetailViewAction>
    @ObservedObject
    var viewStore: ViewStore<SearchDetailViewState, SearchDetailViewAction>
    
    init(store: Store<SearchDetailViewState, SearchDetailViewAction>) {
        self.store = store
        viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("profileImage: \n\(viewStore.state.userDetailInformation.profileImage)")
                Text("githubUrl: \n\(viewStore.state.userDetailInformation.githubUrl)")
                Text("followersUrl: \n\(viewStore.state.userDetailInformation.followersUrl)")
                Text("followingUrl: \n\(viewStore.state.userDetailInformation.followingUrl)")
                Text("gists_url: \n\(viewStore.state.userDetailInformation.gistsUrl)")
                Text("starredUrl: \n\(viewStore.state.userDetailInformation.starredUrl)")
                Text("subscriptionsUrl: \n\(viewStore.state.userDetailInformation.subscriptionsUrl)")
                Text("organizationsUrl: \n\(viewStore.state.userDetailInformation.organizationsUrl)")
                Text("reposUrl: \n\(viewStore.state.userDetailInformation.reposUrl)")
                Text("eventsUrl: \n\(viewStore.state.userDetailInformation.eventsUrl)")
            }.task {
                viewStore.send(.requestUserDetailInformation)
            }
        }
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView(store: Store(initialState: SearchDetailViewState(),
                                      reducer: searchDetailViewReducer,
                                      environment: SearchDetailViewEnvironment(mainQueue: .main)))
    }
}

