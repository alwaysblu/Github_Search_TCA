//
//  UserInformationResponseDTO+Mapping.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import GEntities

// MARK: - Data Transfer Object
public struct SearchedUsersInformationResponseDTO: Decodable {
  let total_count: Int
  let items: [SearchedUserInformation]

  public init(
    total_count: Int,
    items: [SearchedUserInformation]
  ) {
    self.total_count = total_count
    self.items = items
  }
}

extension SearchedUsersInformationResponseDTO {
  public struct SearchedUserInformation: Decodable {
    let login: String
    let avatar_url: String

    public init(
      login: String,
      avatar_url: String
    ) {
      self.login = login
      self.avatar_url = avatar_url
    }
  }
}

// MARK: - Mappings to Domain
extension SearchedUsersInformationResponseDTO {
  public func toDomain<T>(pagination: Pagination = .empty, entity: T.Type) throws -> Entity where T: Entity {
    switch entity {
    case is UserInformationPage.Type :
      return mapUserInformationPage(pagination: pagination)
    default :
      throw DTOError.typeNotMatch
    }
  }

  private func mapUserInformationPage(pagination: Pagination) -> UserInformationPage {
    return UserInformationPage(
      totalCount: total_count,
      informations: items.map { $0.toDomain() },
      pagination: pagination
    )
  }
}

extension SearchedUsersInformationResponseDTO.SearchedUserInformation {
  public func toDomain() -> SearchedUserInformation {
    return .init(
      userName: login,
      profileUrl: avatar_url
    )
  }
}
