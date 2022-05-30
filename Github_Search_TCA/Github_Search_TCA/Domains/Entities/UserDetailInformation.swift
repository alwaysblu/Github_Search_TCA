//
//  UserDetailInformation.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct UserDetailInformation: Equatable {
    var profileImage: String
    var githubUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var name: String
    var company: String
    var blog: String
    var location: String
    var email: String
    var bio: String
    var twitterUsername: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
}

extension UserDetailInformation {
    static let empty = UserDetailInformation(profileImage: "",
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
                                             following: 0)
}
