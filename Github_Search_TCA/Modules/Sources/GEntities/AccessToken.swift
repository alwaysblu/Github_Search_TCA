//
//  AccessToken.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

public struct AccessToken: Equatable {
  public let accessToken: String
  let tokenType: String
  let scope: String

  public init(
    accessToken: String,
    tokenType: String,
    scope: String
  ) {
    self.accessToken = accessToken
    self.tokenType = tokenType
    self.scope = scope
  }
}

extension AccessToken {
  public static let empty = AccessToken(
    accessToken: "",
    tokenType: "",
    scope: ""
  )
}


