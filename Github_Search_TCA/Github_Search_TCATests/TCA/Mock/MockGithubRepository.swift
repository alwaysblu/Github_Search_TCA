//
//  MockGithubRepository.swift
//  Github_Search_TCATests
//
//  Created by 맥북 on 2022/06/14.
//
import XCTest
import ComposableArchitecture
import Foundation


struct MockGithubRepository {
  var repository: GithubRepository
}

extension MockGithubRepository {
  static let success = MockGithubRepository(repository: SuccessGithubRepository())
  static let fail = MockGithubRepository(repository: FailGithubRepository())
}

extension MockGithubRepository {
  static let userInformationPage = UserInformationPage(totalCount: 0,
                                                informations: [],
                                                pagination: .empty)
  static let userDetailInformation = UserDetailInformation(profileImage: "test",
                                                    githubUrl: "test",
                                                    followersUrl: "test",
                                                    followingUrl: "test",
                                                    gistsUrl: "test",
                                                    starredUrl: "test",
                                                    subscriptionsUrl: "test",
                                                    organizationsUrl: "test",
                                                    reposUrl: "test",
                                                    eventsUrl: "test",
                                                    receivedEventsUrl: "test",
                                                    type: "test",
                                                    name: "test",
                                                    company: "test",
                                                    blog: "test",
                                                    location: "test",
                                                    email: "test",
                                                    bio: "test",
                                                    twitterUsername: "test",
                                                    publicRepos: 9,
                                                    publicGists: 9,
                                                    followers: 9,
                                                    following: 9)
}

extension MockGithubRepository {
  struct SuccessGithubRepository: GithubRepository {
    func fetchGithubUsers(query: String?, page: Int?, countPerPage: Int?, next: String?, accessToken: String) -> Effect<UserInformationPage, Error> {
      return Effect.task {
        return userInformationPage
      }
    }

    func requestGithubUserDetailInformation(userName: String, accessToken: String) -> Effect<UserDetailInformation, Error> {
      return Effect.task {
        return userDetailInformation
      }
    }

    func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
      return Effect.task {
        return AccessToken.empty
      }
    }
  }

  struct FailGithubRepository: GithubRepository {
    func fetchGithubUsers(query: String?, page: Int?, countPerPage: Int?, next: String?, accessToken: String) -> Effect<UserInformationPage, Error> {
      return Effect.task {
        throw TestError.network
      }
    }

    func requestGithubUserDetailInformation(userName: String, accessToken: String) -> Effect<UserDetailInformation, Error> {
      return Effect.task {
        throw TestError.network
      }
    }

    func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
      return Effect.task {
        throw TestError.network
      }
    }
  }
}
