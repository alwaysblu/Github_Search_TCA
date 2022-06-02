//
//  NetworkManager.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

protocol NetworkManager {
    init(networkLoader: NetworkLoader)
    // MARK: Interface functions
    
    func sendRequest<Response>(url: URL,
                               response: Response.Type,
                               accessToken: String) async throws -> Result<(Response, URLResponse), Error>  where Response: Decodable
    
    func sendRequest<Request, Response>(url: URL,
                                        request: RequestData<Request>,
                                        response: Response.Type,
                                        accessToken: String) async throws -> Result<(Response, URLResponse), Error> where Request: Encodable, Response: Decodable
}

final public class DefaultNetworkManager: NetworkManager {
    private var networkLoader: NetworkLoader
    
    init(networkLoader: NetworkLoader) {
        self.networkLoader = networkLoader
    }
    
    // MARK: Interface functions
    
    func sendRequest<Response>(url: URL,
                               response: Response.Type,
                               accessToken: String) async throws -> Result<(Response, URLResponse), Error>  where Response: Decodable {
        var request = URLRequest(url: url)
        if accessToken != "" {
            request.setValue("token " + accessToken,
                             forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        request.httpMethod = HTTPMethod.get.rawValue
        let result = try await networkLoader.loadData(with: request)
        
        return handleResponseData(result: result)
    }
    
    func sendRequest<Request, Response>(url: URL,
                                        request: RequestData<Request>,
                                        response: Response.Type,
                                        accessToken: String = "") async throws -> Result<(Response, URLResponse), Error> where Request: Encodable, Response: Decodable {
        
        guard let request = setRequest(url: url,
                                       httpMethod: request.httpMethod,
                                       requestObject: request.request,
                                       accessToken: accessToken) else { return .failure(DataError.invalidData) }
        
        let result = try await networkLoader.loadData(with: request)
        
        return handleResponseData(result: result)
    }
    
    
    // MARK: Private functions
    
    private func setRequest<Request>(url: URL,
                                     httpMethod: HTTPMethod,
                                     requestObject: Request?,
                                     accessToken: String) -> URLRequest? where Request: Encodable {
        var request = URLRequest(url: url)
        
        request.setValue(DataForm.applicationJSON.rawValue,
                         forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(DataForm.applicationJSON.rawValue,
                         forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        if accessToken != "" {
            request.setValue("token " + accessToken,
                             forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        request.httpMethod = httpMethod.rawValue
        
        if let requestObject = requestObject {
            request.httpBody = encodedData(data: requestObject)
        }
        
        return request
    }
    
    private func encodedData<T>(data: T) -> Data? where T: Encodable {
        let encoder = JSONEncoder()
        
        return try? encoder.encode(data)
    }
    
    private func handleResponseData<Response>(result: Result<(Data, URLResponse), Error>)
    -> Result<(Response, URLResponse), Error>
    where Response: Decodable {
        switch result {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(Response.self, from: data.0)
                
                return .success((response, data.1))
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

