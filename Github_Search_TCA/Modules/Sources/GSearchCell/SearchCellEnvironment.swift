//
//  SearchCellEnvironment.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import GCommon
import GRepositories
import ComposableArchitecture

public struct SearchCellEnvironment {
  let githubRepository: GithubRepository
  let mainQueue: AnySchedulerOf<DispatchQueue>

  public init(
    githubRepository: GithubRepository,
    mainQueue: AnySchedulerOf<DispatchQueue>
  ) {
    self.githubRepository = githubRepository
    self.mainQueue = mainQueue
  }
}

extension SearchCellEnvironment {
  public static let mock = SearchCellEnvironment(
    githubRepository: GithubRepositoryMock(),
    mainQueue: .main
  )
}
