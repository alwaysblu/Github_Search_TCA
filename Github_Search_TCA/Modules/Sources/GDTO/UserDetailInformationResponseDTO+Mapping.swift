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

  public init(
    avatar_url: String?,
    html_url: String?,
    followers_url: String?,
    following_url: String?,
    gists_url: String?,
    starred_url: String?,
    subscriptions_url: String?,
    organizations_url: String?,
    repos_url: String?,
    events_url: String?,
    received_events_url: String?,
    type: String?,
    name: String?,
    company: String?,
    blog: String?,
    location: String?,
    email: String?,
    bio: String?,
    twitter_username: String?,
    public_repos: Int?,
    public_gists: Int?,
    followers: Int?,
    following: Int?
  ) {
    self.avatar_url = avatar_url
    self.html_url = html_url
    self.followers_url = followers_url
    self.following_url = following_url
    self.gists_url = gists_url
    self.starred_url = starred_url
    self.subscriptions_url = subscriptions_url
    self.organizations_url = organizations_url
    self.repos_url = repos_url
    self.events_url = events_url
    self.received_events_url = received_events_url
    self.type = type
    self.name = name
    self.company = company
    self.blog = blog
    self.location = location
    self.email = email
    self.bio = bio
    self.twitter_username = twitter_username
    self.public_repos = public_repos
    self.public_gists = public_gists
    self.followers = followers
    self.following = following
  }
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
