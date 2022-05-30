//
//  UserDetailInformationResponseDTO+Mapping.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct UserDetailInformationResponseDTO: Decodable {
    var avatar_url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var bio: String?
    var twitter_username: String?
    var public_repos: Int?
    var public_gists: Int?
    var followers: Int?
    var following: Int?
}

extension UserDetailInformationResponseDTO {
    func toDomain() -> UserDetailInformation {
        return UserDetailInformation(profileImage: avatar_url ?? "",
                                     githubUrl: html_url ?? "",
                                     followersUrl: followers_url ?? "",
                                     followingUrl: following_url ?? "",
                                     gistsUrl: gists_url ?? "",
                                     starredUrl: starred_url ?? "",
                                     subscriptionsUrl: subscriptions_url ?? "",
                                     organizationsUrl: organizations_url ?? "",
                                     reposUrl: repos_url ?? "",
                                     eventsUrl: events_url ?? "",
                                     receivedEventsUrl: received_events_url ?? "",
                                     type: type ?? "",
                                     name: name ?? "",
                                     company: company ?? "",
                                     blog: blog ?? "",
                                     location: location ?? "",
                                     email: email ?? "",
                                     bio: bio ?? "",
                                     twitterUsername: twitter_username ?? "",
                                     publicRepos: public_repos ?? 0,
                                     publicGists: public_gists ?? 0,
                                     followers: followers ?? 0,
                                     following: following ?? 0)
    }
}
