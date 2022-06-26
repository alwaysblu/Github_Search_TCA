//
//  AccessTokenResponseDTO+Mapping.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import GEntities

public struct AccessTokenResponseDTO: Decodable {
  let access_token: String
  let token_type: String
  let scope: String
  
  public init(
    access_token: String,
    token_type: String,
    scope: String
  ) {
    self.access_token = access_token
    self.token_type = token_type
    self.scope = scope
  }
}

extension AccessTokenResponseDTO {
  public func toDomain() -> AccessToken {
    return .init(
      accessToken: access_token,
      tokenType: token_type,
      scope: scope
    )
  }
}

extension AccessTokenResponseDTO {
  public static let empty = AccessTokenResponseDTO(
    access_token: "",
    token_type: "",
    scope: ""
  )
}
