//
//  APIURL.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import Foundation

public enum APIURL {
  private static let apiBaseURL = "https://api.github.com"
  private static let githubBaseUrl = "https://github.com"
  public static let emptyURL = URL(fileURLWithPath: "")

  public static func getGithubUsersURL(
    query: String? = nil,
    page: Int? = nil,
    countPerPage: Int? = nil,
    next: String? = nil
  ) -> URL {
    if let query = query,
       let page = page,
       let countPerPage = countPerPage {
      let path = "/search/users?q=\(query)&page=\(page)&per_page=\(countPerPage)"

      return URL(string: apiBaseURL + path) ?? emptyURL
    } else if let next = next {

      return URL(string: next) ?? emptyURL
    }

    return emptyURL
  }

  public static func getGithubSignInURL() -> URL {
    let path = "/login/oauth/authorize?client_id=\(GithubSecretData.clientId)&scope=\(GithubSecretData.scopes)"
    return URL(string: githubBaseUrl + path) ?? emptyURL
  }

  public static func requestAccessToken(code: String) -> URL {
    let path = "/login/oauth/access_token?client_id=\(GithubSecretData.clientId)&client_secret=\(GithubSecretData.clientSecret)&code=\(code)"
    return URL(string: githubBaseUrl + path) ?? emptyURL
  }

  public static func requestGithubUserDetailInformation(userName: String) -> URL {
    let path = "/users/\(userName)"
    return URL(string: apiBaseURL + path) ?? emptyURL
  }

}
