//
//  SearchedUsersInformationResponseDTO+Mapping.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

// MARK: - Data Transfer Object
struct SearchedUsersInformationResponseDTO: Decodable {
    let total_count: Int
    let items: [SearchedUserInformation]
}

extension SearchedUsersInformationResponseDTO {
    struct SearchedUserInformation: Decodable {
        let login: String
        let avatar_url: String
    }
}

// MARK: - Mappings to Domain
extension SearchedUsersInformationResponseDTO {
    func toDomain() -> UserInformationPage {
        return .init(totalCount: total_count, informations: items.map { $0.toDomain() })
    }
}

extension SearchedUsersInformationResponseDTO.SearchedUserInformation {
    func toDomain() -> SearchedUserInformation {
        return .init(userName: login, profileUrl: avatar_url)
    }
}
