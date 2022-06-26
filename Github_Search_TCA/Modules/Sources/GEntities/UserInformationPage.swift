//
//  UserInformation.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import Foundation

public struct UserInformationPage: Equatable {
  public var totalCount: Int
  public var informations: [SearchedUserInformation]
  public var pagination: Pagination

  public init(
    totalCount: Int,
    informations: [SearchedUserInformation],
    pagination: Pagination
  ) {
    self.totalCount = totalCount
    self.informations = informations
    self.pagination = pagination
  }
}

public struct SearchedUserInformation: Equatable {
  public let userName: String
  public let profileUrl: String

  public init(
    userName: String,
    profileUrl: String
  ) {
    self.userName = userName
    self.profileUrl = profileUrl
  }
}

public struct Pagination: Equatable {
  public var nextUrl: String
  public var isFirst: Bool
  public var isLast: Bool

  public init(
    nextUrl: String,
    isFirst: Bool,
    isLast: Bool
  ) {
    self.nextUrl = nextUrl
    self.isFirst = isFirst
    self.isLast = isLast
  }
}

extension Pagination {
  public static let empty = Pagination(
    nextUrl: "",
    isFirst: false,
    isLast: false
  )
}
