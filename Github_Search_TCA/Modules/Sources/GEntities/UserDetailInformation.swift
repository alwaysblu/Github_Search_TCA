//
//  UserDetailInformation.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

public struct UserDetailInformation: Equatable, Entity {
  public var profileImage: String
  public var githubUrl: String
  public var followersUrl: String
  public var followingUrl: String
  public var gistsUrl: String
  public var starredUrl: String
  public var subscriptionsUrl: String
  public var organizationsUrl: String
  public var reposUrl: String
  public var eventsUrl: String
  public var receivedEventsUrl: String
  public var type: String
  public var name: String
  public var company: String
  public var blog: String
  public var location: String
  public var email: String
  public var bio: String
  public var twitterUsername: String
  public var publicRepos: Int
  public var publicGists: Int
  public var followers: Int
  public var following: Int
  
  public init(
    profileImage: String,
    githubUrl: String,
    followersUrl: String,
    followingUrl: String,
    gistsUrl: String,
    starredUrl: String,
    subscriptionsUrl: String,
    organizationsUrl: String,
    reposUrl: String,
    eventsUrl: String,
    receivedEventsUrl: String,
    type: String,
    name: String,
    company: String,
    blog: String,
    location: String,
    email: String,
    bio: String,
    twitterUsername: String,
    publicRepos: Int,
    publicGists: Int,
    followers: Int,
    following: Int
  ) {
    self.profileImage = profileImage
    self.githubUrl = githubUrl
    self.followersUrl = followersUrl
    self.followingUrl = followingUrl
    self.gistsUrl = gistsUrl
    self.starredUrl = starredUrl
    self.subscriptionsUrl = subscriptionsUrl
    self.organizationsUrl = organizationsUrl
    self.reposUrl = reposUrl
    self.eventsUrl = eventsUrl
    self.receivedEventsUrl = receivedEventsUrl
    self.type = type
    self.name = name
    self.company = company
    self.blog = blog
    self.location = location
    self.email = email
    self.bio = bio
    self.twitterUsername = twitterUsername
    self.publicRepos = publicRepos
    self.publicGists = publicGists
    self.followers = followers
    self.following = following
  }
}

extension UserDetailInformation {
  public static let empty = UserDetailInformation(
    profileImage: "",
    githubUrl: "",
    followersUrl: "",
    followingUrl: "",
    gistsUrl: "",
    starredUrl: "",
    subscriptionsUrl: "",
    organizationsUrl: "",
    reposUrl: "",
    eventsUrl: "",
    receivedEventsUrl: "",
    type: "",
    name: "",
    company: "",
    blog: "",
    location: "",
    email: "",
    bio: "",
    twitterUsername: "",
    publicRepos: 0,
    publicGists: 0,
    followers: 0,
    following: 0
  )
}
