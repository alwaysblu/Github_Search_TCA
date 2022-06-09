//
//  GithubRepository.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import SwiftUI
import ComposableArchitecture

struct GithubRepository {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchGithubUsers(query: String? = nil,
                          page: Int? = nil,
                          countPerPage: Int? = nil,
                          next: String? = nil,
                          accessToken: String) -> Effect<UserInformationPage, Error> {
        let url = APIURL.getGithubUsersURL(query: query,
                                           page: page,
                                           countPerPage: countPerPage,
                                           next: next)
        
        return Effect.task {
            let result = try await networkManager.sendRequest(url: url,
                                                              response: SearchedUsersInformationResponseDTO.self,
                                                              accessToken: accessToken)
            switch result {
            case .success((let responseDTO, let urlResponse)):
                let pagination = urlResponse.getPagination()
                let userInformationPage = responseDTO.toDomain(pagination: pagination)
                return userInformationPage
            case .failure(let error):
                "\(error)".log("GithubRepository/fetchGithubUsers")
                throw error
            }
        }
    }
    
    func requestGithubUserDetailInformation(userName: String, accessToken: String) -> Effect<UserDetailInformation, Error> {
        let url = APIURL.requestGithubUserDetailInformation(userName: userName)
        
        return Effect.task {
            let result = try await networkManager.sendRequest(url: url,
                                                              response: UserDetailInformationResponseDTO.self,
                                                              accessToken: accessToken)
            switch result {
            case .success((let responseDTO, _)):
                return responseDTO.toDomain()
            case .failure(let error):
                "\(error)".log("GithubRepository/requestGithubUserDetailInformation")
                throw error
            }
        }
    }
    
    func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
        let url = APIURL.requestAccessToken(code: code)
        
        return Effect.task {
            let request = RequestData(httpMethod: .post,
                                      request: AccessTokenRequestDTO(client_id: GithubSecretData.clientId,
                                                                     client_secret: GithubSecretData.clientSecret,
                                                                     code: code))
            let result = try await networkManager.sendRequest(url: url,
                                                              request: request,
                                                              response: AccessTokenResponseDTO.self,
                                                              accessToken: "")
            switch result {
            case .success((let responseDTO, _)):
                return responseDTO.toDomain()
            case .failure(let error):
                "\(error)".log("GithubRepository/requestAccessToken")
                throw error
            }
        }
    }
}

