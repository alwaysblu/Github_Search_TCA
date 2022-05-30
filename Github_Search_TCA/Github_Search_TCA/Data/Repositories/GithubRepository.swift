//
//  GithubRepository.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

struct GithubRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchGithubUsers(query: String, page: Int, countPerPage: Int) -> Effect<UserInformationPage, Error> {
        guard let url = APIURL.getGithubUsersURL(query: query, page: page, countPerPage: countPerPage) else { return .none }
        
        return Effect.task {
            let result = try await networkManager.sendRequest(url: url, response: SearchedUsersInformationResponseDTO.self)
            
            switch result {
            case .success(let responseDTO):
                return responseDTO.toDomain()
            case .failure(let error):
                "\(error)".log("GithubRepository/fetchGithubUsers")
                throw error
            }
        }
    }
    
    func requestGithubUserDetailInformation(userName: String) -> Effect<UserDetailInformation, Error> {
        guard let url = APIURL.requestGithubUserDetailInformation(userName: userName) else { return .none }
        
        return Effect.task {
            let result = try await networkManager.sendRequest(url: url, response: UserDetailInformationResponseDTO.self)
            
            switch result {
            case .success(let responseDTO):
                return responseDTO.toDomain()
            case .failure(let error):
                "\(error)".log("GithubRepository/requestGithubUserDetailInformation")
                throw error
            }
        }
    }
    
    func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
        guard let url = APIURL.requestAccessToken(code: code) else { return .none }
        
        return Effect.task {
            let request = RequestData(httpMethod: .post,
                                      request: AccessTokenRequestDTO(client_id: GithubSecretData.clientId,
                                                                     client_secret: GithubSecretData.clientSecret,
                                                                     code: code))
            let result = try await networkManager.sendRequest(url: url,
                                                              request: request,
                                                              response: AccessTokenResponseDTO.self)
            switch result {
            case .success(let responseDTO):
                return responseDTO.toDomain()
            case .failure(let error):
                "\(error)".log("GithubRepository/requestAccessToken")
                throw error
            }
        }
    }
}
