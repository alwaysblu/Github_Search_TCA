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
                SearchBar(searchQuery: viewStore.binding(\.$searchQuery))
                
                List {
                    ForEachStore(store.scope(state: \.searchedResults,
                                             action: SearchAction.searchCellResult(id:action:)),
                                 content: SearchCell.init(store:)
                    )
                    if viewStore.isLastResult {
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
                .navigationBarTitle("Github Search")
                .navigationBarItems(
                    trailing: HStack {
                        Link(destination: viewStore.githubSignInURL!) {
                            Text(viewStore.loginButtonText).bold()
                        }
                    }
                )
                .onReceive(
                    NotificationCenter
                        .default
                        .publisher(for: UIApplication.willEnterForegroundNotification)
                ) { _ in
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
                                                                   mainQueue: .main,
                                                                   emptyUserDetailInformation: .empty
                                                                  )
                                   )
            )
        }
    }
}
