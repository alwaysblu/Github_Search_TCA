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
  static let success = SuccessGithubRepository()
  static let fail = FailGithubRepository()
}

extension MockGithubRepository {
  static let bindingUserInformationPage = UserInformationPage(totalCount: 1,
                                                informations: [SearchedUserInformation(userName: "test", profileUrl: "test")],
                                                       pagination: .init(nextUrl: "test", isFirst: true, isLast: true))
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
  static let accessToken = AccessToken(accessToken: "test",
                                       tokenType: "test",
                                       scope: "test")
}

extension MockGithubRepository {
  struct SuccessGithubRepository: GithubRepository {
    func fetchGithubUsers(query: String?, page: Int?, countPerPage: Int?, next: String?, accessToken: String) -> Effect<UserInformationPage, Error> {
      return Effect.task {
        return bindingUserInformationPage
      }
    }

    func requestGithubUserDetailInformation(userName: String, accessToken: String) -> Effect<UserDetailInformation, Error> {
      return Effect.task {
        return userDetailInformation
      }
    }

    func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
      return Effect.task {
        return accessToken
      }
    }
  }
}

extension MockGithubRepository {
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
