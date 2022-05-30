//
//  NetworkLoader.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

protocol NetworkLoader {
    init(session: URLSession)
    
    func loadData(with url: URL) async throws -> Result<Data, Error>
    
    func loadData(with request: URLRequest) async throws -> Result<Data, Error>
}

struct DefaultNetworkLoader: NetworkLoader {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func checkValidation(data: Data?, response: URLResponse?) -> Result<Data, Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(DataError.invalidResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return .failure(DataError.statusCode)
        }
        
        guard let data = data else {
            return .failure(DataError.invalidData)
        }
        
        return .success(data)
    }
    
    func loadData(with url: URL) async throws -> Result<Data, Error> {
        let (data, response) = try await session.data(for: URLRequest(url: url))
        let result = self.checkValidation(data: data, response: response)
        
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func loadData(with request: URLRequest) async throws -> Result<Data, Error> {
        let (data, response) = try await session.data(for: request)
        let result = self.checkValidation(data: data, response: response)
        
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}
