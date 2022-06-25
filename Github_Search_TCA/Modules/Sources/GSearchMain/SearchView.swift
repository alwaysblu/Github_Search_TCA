//
//  ContentView.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/24.
//

import SwiftUI
import GCommon
import ComposableArchitecture
import GSearchCell

public struct SearchView: View {
  private let store: Store<SearchState, SearchAction>
  @ObservedObject
  var viewStore: ViewStore<SearchState, SearchAction>
  
  public init(store: Store<SearchState, SearchAction>) {
    self.store = store
    viewStore = ViewStore(self.store)
  }
  
  public var body: some View {
    NavigationView {
      VStack {
        SearchBar(searchQuery: viewStore.binding(\.$searchQuery))
        List {
          ForEachStore(store.scope(state: \.searchedResults,
                                   action: SearchAction.searchCellResult(id:action:)),
                       content: SearchCell.init(store:)
          )
          
          if viewStore.pagination.isLast {
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
            Link(destination: viewStore.githubSignInURL) {
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
  
  public struct SearchView_Previews: PreviewProvider {
    public static var previews: some View {
      SearchView(store:
          .init(
            initialState:
              SearchState(
                showSignInView: false,
                isLoggedIn: false,
                searchQuery: "",
                searchedResults: [],
                code: "",
                accessToken: .empty,
                countPerPage: 0,
                githubSignInURL: URL(fileURLWithPath: ""),
                pagination: .empty,
                loginButtonText: ""
              ),
            reducer: searchReducer,
            environment: .mock
          )
      )
    }
  }
}
