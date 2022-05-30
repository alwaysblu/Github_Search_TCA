//
//  AccessTokenResponseDTO+Mapping.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct AccessTokenResponseDTO: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
}

extension AccessTokenResponseDTO {
    func toDomain() -> AccessToken {
        return .init(accessToken: access_token, tokenType: token_type, scope: scope)
    }
}
