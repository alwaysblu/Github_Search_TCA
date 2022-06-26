//
//  SearchCellState.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import GEntities
import GCommon
import Foundation
import ComposableArchitecture

public struct SearchCellState: Equatable, Identifiable {
  let imageUrl: String
  let userName: String
  public let id: UUID?
  var userDetailInformation: UserDetailInformation
  var isUserDataExist: Bool
  var accessToken: AccessToken

  public init(
    imageUrl: String,
    userName: String,
    id: UUID?,
    userDetailInformation: UserDetailInformation = .empty,
    isUserDataExist: Bool = false,
    accessToken: AccessToken = .empty
  ) {
    self.imageUrl = imageUrl
    self.userName = userName
    self.id = id
    self.userDetailInformation = userDetailInformation
    self.isUserDataExist = isUserDataExist
    self.accessToken = accessToken
  }
}
