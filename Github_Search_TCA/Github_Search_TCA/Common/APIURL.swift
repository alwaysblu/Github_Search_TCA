//
//  APIURL.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

enum APIURL {
    private static let apiBaseURL = "https://api.github.com"
    private static let githubBaseUrl = "https://github.com"
    
    static func getGithubUsersURL(query: String, page: Int, countPerPage: Int) -> URL? {
        let path = "/search/users?q=\(query)&page=\(page)&per_page=\(countPerPage)"
        return URL(string: apiBaseURL + path)
    }
    
    static func getGithubSignInURL() -> URL? {
        let path = "/login/oauth/authorize?client_id=\(GithubSecretData.clientId)&scopes=\(GithubSecretData.scopes)"
        return URL(string: githubBaseUrl + path)
    }
    
    static func requestAccessToken(code: String) -> URL? {
        let path = "/login/oauth/access_token?client_id=\(GithubSecretData.clientId)&client_secret=\(GithubSecretData.clientSecret)&code=\(code)"
        return URL(string: githubBaseUrl + path)
    }
    
    static func requestGithubUserDetailInformation(userName: String) -> URL? {
        let path = "/users/\(userName)"
        return URL(string: apiBaseURL + path)
    }
    
}
