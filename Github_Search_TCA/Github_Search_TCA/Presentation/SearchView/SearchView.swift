//
//  ContentView.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/24.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct SearchView: View {
    private let store: Store<SearchState, SearchAction>
    @ObservedObject
    var viewStore: ViewStore<SearchState, SearchAction>
    
    init(store: Store<SearchState, SearchAction>) {
        self.store = store
        viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(store: store)
                
                List {
                    ForEachStore(store.scope(state: \.searchedResults,
                                                  action: SearchAction.searchCellResult(id:action:)),
                                 content: SearchCell.init(store:))
                    ForEach(viewStore.searchedResults){ result in
                        if viewStore.searchedResults.last == result,
                           viewStore.totalPage > 0 ,
                           viewStore.totalPage != viewStore.currentPage {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .onAppear {
                                        viewStore.send(.fetchUsers)
                                    }
                                Spacer()
                            }
                        }
                    }
                }.navigationBarTitle("Github Search")
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Link(destination: APIURL.getGithubSignInURL()!) {
                                    let text = viewStore.code == "" ? "Login" : "Already Logged In"
                                    Text(text).bold()
                                }
                            }
                    ).onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        viewStore.send(.requestAccessToken)
                    }
            }
        }
    }
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            let networkManager = DefaultNetworkManager(networkLoader:
                                                        DefaultNetworkLoader(session: .shared))
            SearchView(store: Store(initialState: SearchState(),
                                    reducer: searchReducer,
                                    environment: SearchEnvironment(githubRepository:
                                                                    GithubRepository(networkManager: networkManager),
                                                                   mainQueue: .main)))
        }
    }
}
