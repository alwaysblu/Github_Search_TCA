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
  let githubRepository: GitRepository
  let mainQueue: AnySchedulerOf<DispatchQueue>

  public init(
    githubRepository: GitRepository,
    mainQueue: AnySchedulerOf<DispatchQueue>
  ) {
    self.githubRepository = githubRepository
    self.mainQueue = mainQueue
  }
}

extension SearchCellEnvironment {
  public static let mock = SearchCellEnvironment(
    githubRepository: GitRepositoryMock(),
    mainQueue: .main
  )
}
