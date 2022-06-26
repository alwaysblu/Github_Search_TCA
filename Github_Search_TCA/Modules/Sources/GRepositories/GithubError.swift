//
//  File.swift
//  
//
//  Created by 최정민 on 2022/06/26.
//

import Foundation
import Moya

enum GithubError: Error {
  case moya(MoyaError)
}
