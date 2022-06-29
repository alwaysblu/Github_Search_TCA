//
//  File.swift
//  
//
//  Created by 최정민 on 2022/06/29.
//

import Foundation
import GRepositories
import Combine
import GDTO
import GEntities

public struct MockGitRepository {
  public static let success = SuccessGitRepository()
  public static let fail = FailGitRepository()
}

extension MockGitRepository {

  static let searchedUserInformations: [SearchedUserInformation] = [
    SearchedUserInformation(userName: "1", profileUrl: "image1"),
    SearchedUserInformation(userName: "2", profileUrl: "image2"),
    SearchedUserInformation(userName: "3", profileUrl: "image3"),
    SearchedUserInformation(userName: "4", profileUrl: "image4"),
    SearchedUserInformation(userName: "5", profileUrl: "image5")
  ]

  static let userInformationPage = UserInformationPage(
    totalCount: 5,
    informations: searchedUserInformations,
    pagination: Pagination(
      nextUrl: "test",
      isFirst: true,
      isLast: false
    )
  )

  static let userDetailInformationResponseDTO = UserDetailInformationResponseDTO(
    avatar_url: "test",
    html_url: "test",
    followers_url: "test",
    following_url: "test",
    gists_url: "test",
    starred_url: "test",
    subscriptions_url: "test",
    organizations_url: "test",
    repos_url: "test",
    events_url: "test",
    received_events_url: "test",
    type: "test",
    name: "test",
    company: "test",
    blog: "test",
    location: "test",
    email: "test",
    bio: "test",
    twitter_username: "test",
    public_repos: 0,
    public_gists: 0,
    followers: 0,
    following: 0
  )

  static let accessTokenResponseDTO = AccessTokenResponseDTO(
    access_token: "test",
    token_type: "test",
    scope: "test"
  )
}

extension MockGitRepository {
  public struct SuccessGitRepository: GitRepository {
    public init() {}

    public func fetchGithubUsers(
      query: String?,
      page: Int?,
      countPerPage: Int?,
      next: String?,
      accessToken: String
    ) -> AnyPublisher<UserInformationPage, Error> {
      return Just(userInformationPage)
        .setFailureType(to: Error.self)
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }

    public func requestGithubUserDetailInformation(
      userName: String,
      accessToken: String
    ) -> AnyPublisher<UserDetailInformationResponseDTO, Error> {
      return Just(userDetailInformationResponseDTO)
        .setFailureType(to: Error.self)
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }

    public func requestAccessToken(code: String) -> AnyPublisher<AccessTokenResponseDTO, Error> {
      return Just(accessTokenResponseDTO)
        .setFailureType(to: Error.self)
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
  }

  public struct FailGitRepository: GitRepository {
    public init() {}

    public func fetchGithubUsers(
      query: String?,
      page: Int?,
      countPerPage: Int?,
      next: String?,
      accessToken: String
    ) -> AnyPublisher<UserInformationPage, Error> {
      return Just<UserInformationPage?>(nil)
        .setFailureType(to: Error.self)
        .tryMap {_ in
          throw TestError.network
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }

    public func requestGithubUserDetailInformation(
      userName: String,
      accessToken: String
    ) -> AnyPublisher<UserDetailInformationResponseDTO, Error> {
      return Just<UserDetailInformationResponseDTO?>(nil)
        .setFailureType(to: Error.self)
        .tryMap {_ in
          throw TestError.network
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }

    public func requestAccessToken(
      code: String
    ) -> AnyPublisher<AccessTokenResponseDTO, Error> {
      return Just<AccessTokenResponseDTO?>(nil)
        .setFailureType(to: Error.self)
        .tryMap {_ in 
          throw TestError.network
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
  }
}
