//
//  File.swift
//  
//
//  Created by 최정민 on 2022/06/26.
//

import GInfra
import GEntities
import GDTO
import GCommon
import Moya
import Combine
import Foundation
import CombineMoya

public protocol GitRepository {
  func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> AnyPublisher<SearchedUsersInformationResponseDTO, Error>

  func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> AnyPublisher<UserDetailInformationResponseDTO, Error>

  func requestAccessToken(code: String) -> AnyPublisher<AccessTokenResponseDTO, Error>
}


public struct GitRepositoryLive: GitRepository {
  let provider: MoyaProvider<API>
  private let cURLPlugin: NetworkLoggerPlugin = .init(
    configuration: .init(
      formatter: .init(),
      logOptions: .formatRequestAscURL
    )
  )

  public init() {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 300
    let session = Session(configuration: configuration)
    provider = MoyaProvider<API>(
      session: session,
      plugins: [cURLPlugin]
    )
  }

  public func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> AnyPublisher<SearchedUsersInformationResponseDTO, Error> {
    provider
      .requestPublisher(
        API.fetchGithubUsers(
          query: query,
          page: page,
          countPerPage: countPerPage,
          next: next,
          accessToken: accessToken
        )
      )
      .map(SearchedUsersInformationResponseDTO.self)
      .mapError(GithubError.moya)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  public func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> AnyPublisher<UserDetailInformationResponseDTO, Error> {
    provider
      .requestPublisher(
        API.requestGithubUserDetailInformation(
          userName: userName,
          accessToken: accessToken
        )
      )
      .map(UserDetailInformationResponseDTO.self)
      .mapError(GithubError.moya)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  public func requestAccessToken(
    code: String
  ) -> AnyPublisher<AccessTokenResponseDTO, Error> {
    provider
      .requestPublisher(
        API.requestAccessToken(
          code: code,
          requestDTO: AccessTokenRequestDTO(
            client_id: GithubSecretData.clientId,
            client_secret: GithubSecretData.clientSecret,
            code: code
          )
        )
      )
      .map(AccessTokenResponseDTO.self)
      .mapError(GithubError.moya)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}

extension GitRepositoryLive {
  enum API {
    case fetchGithubUsers(
      query: String?,
      page: Int?,
      countPerPage: Int?,
      next: String?,
      accessToken: String
    )
    case requestGithubUserDetailInformation(
      userName: String,
      accessToken: String
    )
    case requestAccessToken(
      code: String,
      requestDTO: AccessTokenRequestDTO
    )
  }
}

extension GitRepositoryLive.API: TargetType {
  public var baseURL: URL {
    switch self {
    case .requestGithubUserDetailInformation,
        .fetchGithubUsers:
      return URL(string: APIURL.apiBaseURL)!

    case .requestAccessToken:
      return URL(string: APIURL.githubBaseUrl)!
    }
  }

  public var path: String {
    switch self {
    case .fetchGithubUsers(let query, let page, let countPerPage, let next, _):
      return "/search/users"

    case .requestAccessToken(_, _):
      return "/login/oauth/access_token"

    case .requestGithubUserDetailInformation(let userName, _):
      return "/users/\(userName)"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .fetchGithubUsers,
        .requestGithubUserDetailInformation:
      return .get

    case .requestAccessToken:
      return .post
    }
  }

  public var task: Task {
    switch self {
    case .fetchGithubUsers(let query, let page, let countPerPage, _, _):
      return .requestParameters(
        parameters: [
          "q": query ?? "" as Any,
          "page": page ?? 0 as Any,
          "per_page": countPerPage ?? 0 as Any
        ],
        encoding: URLEncoding.queryString)

    case .requestGithubUserDetailInformation:
      return .requestPlain

    case .requestAccessToken(_, let request):
      return .requestJSONEncodable(request)
    }
  }

  public var headers: [String : String]? {
    switch self {
    case .fetchGithubUsers(_, _, _, _, let accessToken):
      return [
        "content-type": "application/json",
        "Accept": "application/json",
        "Authorization": accessToken
      ]

    case .requestGithubUserDetailInformation(_, let accessToken):
      return [
        "content-type": "application/json",
        "Accept": "application/json",
        "Authorization": accessToken
      ]

    case .requestAccessToken:
      return [
        "content-type": "application/json",
        "Accept": "application/json"
      ]
    }
  }
}

public struct GitRepositoryMock: GitRepository {
  enum MockError: Error {
      case network
  }

  public init() {}

  public func fetchGithubUsers(
    query: String?,
    page: Int?,
    countPerPage: Int?,
    next: String?,
    accessToken: String
  ) -> AnyPublisher<SearchedUsersInformationResponseDTO, Error> {
    return Just<SearchedUsersInformationResponseDTO?>(nil)
      .setFailureType(to: Error.self)
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }

  public func requestGithubUserDetailInformation(
    userName: String,
    accessToken: String
  ) -> AnyPublisher<UserDetailInformationResponseDTO, Error> {
    return Just<UserDetailInformationResponseDTO?>(nil)
      .setFailureType(to: Error.self)
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }

  public func requestAccessToken(
    code: String
  ) -> AnyPublisher<AccessTokenResponseDTO, Error> {
    return Just<AccessTokenResponseDTO?>(nil)
      .setFailureType(to: Error.self)
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }
}
