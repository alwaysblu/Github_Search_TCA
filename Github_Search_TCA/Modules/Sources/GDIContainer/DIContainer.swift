//
//  DIContainer.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/06/09.
//

@_exported import GRepositories
@_exported import GInfra
@_exported import GSearchCell
@_exported import GSearchMain
@_exported import GCommon
@_exported import ComposableArchitecture

public enum DIContainer {
  public static func makeGithubRepository() -> GithubRepository {
    return DefaultGithubRepository(
      networkManager: makeNetworkManager()
    )
  }

  public static func makeNetworkManager() -> NetworkManager {
    return DefaultNetworkManager(
      networkLoader: makeNetworkLoader()
    )
  }

  public static func makeNetworkLoader() -> NetworkLoader {
    return DefaultNetworkLoader(
      session: .shared
    )
  }

  public static func makeSearchCellEnvironment() -> SearchCellEnvironment {
    return SearchCellEnvironment(
      githubRepository: makeGithubRepository(),
      mainQueue: .main
    )
  }

  public static func makeSearchEnvironment() -> SearchEnvironment {
    return SearchEnvironment(
      githubRepository: makeGithubRepository(),
      mainQueue: .main,
      cellEnvironment: makeSearchCellEnvironment()
    )
  }

  public static func makeSearchState() -> SearchState {
    return SearchState(
      githubSignInURL: APIURL.getGithubSignInURL()
    )
  }

  public static func makeSearchStore() -> Store<SearchState, SearchAction> {
    return Store(
      initialState: makeSearchState(),
      reducer: searchReducer,
      environment: makeSearchEnvironment()
    )
  }

  public static func makeSearchViewStore(_ store: Store<SearchState, SearchAction>) -> ViewStore<SearchState, SearchAction> {
    return ViewStore(store)
  }
}
