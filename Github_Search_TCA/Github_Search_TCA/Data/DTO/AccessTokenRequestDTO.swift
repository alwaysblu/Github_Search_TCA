//
//  AccessTokenRequestDTO.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct AccessTokenRequestDTO: Encodable {
    let client_id: String
    let client_secret: String
    let code: String
}
