//
//  GithubRepository.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//
import GInfra
import GEntities
import GDTO
import GCommon
import ComposableArchitecture

public protocol GithubRepository {
  func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> Effect<UserInformationPage, Error>

  func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> Effect<UserDetailInformation, Error>

  func requestAccessToken(code: String) -> Effect<AccessToken, Error>
}

public struct DefaultGithubRepository: GithubRepository {
  private let networkManager: NetworkManager

  public init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }

  public func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> Effect<UserInformationPage, Error> {
    let url = APIURL.getGithubUsersPaginationURL(
      query: query,
      page: page,
      countPerPage: countPerPage,
      next: next
    )

    return Effect.task {
      let result = try await networkManager.sendRequest(
        url: url,
        response: SearchedUsersInformationResponseDTO.self,
        accessToken: accessToken
      )
      switch result {
      case .success((let responseDTO, let urlResponse)):
        let pagination = urlResponse.getPagination()
        let userInformationPage = try responseDTO
          .toDomain(
            pagination: pagination,
            entity: UserInformationPage.self
          ) as! UserInformationPage
        return userInformationPage

      case .failure(let error):
        "\(error)".log("GithubRepository/fetchGithubUsers")
        throw error
      }
    }
  }

  public func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> Effect<UserDetailInformation, Error> {
    let url = APIURL
      .getRequestGithubUserDetailInformationURL(
        userName: userName
      )

    return Effect.task {
      let result = try await networkManager
        .sendRequest(
          url: url,
          response: UserDetailInformationResponseDTO.self,
          accessToken: accessToken
        )
      switch result {
      case .success((let responseDTO, _)):
        return responseDTO
          .toDomain()

      case .failure(let error):
        "\(error)"
          .log("GithubRepository/requestGithubUserDetailInformation")
        throw error
      }
    }
  }

  public func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
    let url = APIURL.getRequestAccessTokenURL(code: code)

    return Effect.task {
      let request = RequestData(
        httpMethod: .post,
        request: AccessTokenRequestDTO(
          client_id: GithubSecretData.clientId,
          client_secret: GithubSecretData.clientSecret,
          code: code
        )
      )
      let result = try await networkManager.sendRequest(
        url: url,
        request: request,
        response: AccessTokenResponseDTO.self,
        accessToken: ""
      )
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


public struct GithubRepositoryMock: GithubRepository {
  enum TestError: Error {
      case network
  }

  public init() {}

  public func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> Effect<UserInformationPage, Error> {
    return Effect.task {
      throw TestError.network
    }
  }

  public func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> Effect<UserDetailInformation, Error> {
    Effect.task {
      throw TestError.network
    }
  }

  public func requestAccessToken(code: String) -> Effect<AccessToken, Error> {
    Effect.task {
      throw TestError.network
    }
  }
}
