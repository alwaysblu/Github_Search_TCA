//
//  AccessTokenRequestDTO.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import GEntities

public struct AccessTokenRequestDTO: Encodable {
  let client_id: String
  let client_secret: String
  let code: String

  public init(
    client_id: String,
    client_secret: String,
    code: String
  ) {
    self.client_id = client_id
    self.client_secret = client_secret
    self.code = code
  }
}
