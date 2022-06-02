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
                    // 마지막인지 리듀서에 물어보기
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
                            // 왠만하면 싱글톤 static 은 최대한 다빼기 (state로) environment를 주입할 때 이외에는 싱글톤이랑 static 사용하지 말 것
                            // environment
                            Text(viewStore.loginButtonText).bold()
                        }
                    }
                )
                .onReceive( // github로부터 code를 받은 경우만 토큰을 요청하기 위해서 onReceive를 사용해야한다.
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
