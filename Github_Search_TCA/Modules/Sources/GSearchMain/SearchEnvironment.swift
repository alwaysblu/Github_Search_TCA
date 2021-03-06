//
//  SearchEnvironment.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//
import GEntities
import GRepositories
import GSearchCell
import ComposableArchitecture

public struct SearchEnvironment {
  var githubRepository: GitRepository
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var cellEnvironment: SearchCellEnvironment
  
  public init(
    githubRepository: GitRepository,
    mainQueue: AnySchedulerOf<DispatchQueue>,
    cellEnvironment: SearchCellEnvironment
  ) {
    self.githubRepository = githubRepository
    self.mainQueue = mainQueue
    self.cellEnvironment = cellEnvironment
  }
}

extension SearchEnvironment {
  public static let mock = SearchEnvironment(
    githubRepository: GitRepositoryMock(),
    mainQueue: .main,
    cellEnvironment: .mock
  )
}
