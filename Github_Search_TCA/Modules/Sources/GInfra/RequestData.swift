//
//  RequestData.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

public struct RequestData<Request> {
    let httpMethod: HTTPMethod
    var request: Request?
    
  public init(
        httpMethod: HTTPMethod,
        request: Request? = nil
    ) {
        self.httpMethod = httpMethod
        self.request = request
    }
}
