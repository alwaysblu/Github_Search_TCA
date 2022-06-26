//
//  UserDetailInformationResponseDTO+Mapping.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import GEntities

public struct UserDetailInformationResponseDTO: Decodable {
  let avatar_url: String?
  let html_url: String?
  let followers_url: String?
  let following_url: String?
  let gists_url: String?
  let starred_url: String?
  let subscriptions_url: String?
  let organizations_url: String?
  let repos_url: String?
  let events_url: String?
  let received_events_url: String?
  let type: String?
  let name: String?
  let company: String?
  let blog: String?
  let location: String?
  let email: String?
  let bio: String?
  let twitter_username: String?
  let public_repos: Int?
  let public_gists: Int?
  let followers: Int?
  let following: Int?
}

extension UserDetailInformationResponseDTO {
  public func toDomain() -> UserDetailInformation {
    return UserDetailInformation(
      profileImage: avatar_url ?? "",
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
      following: following ?? 0
    )
  }
}
