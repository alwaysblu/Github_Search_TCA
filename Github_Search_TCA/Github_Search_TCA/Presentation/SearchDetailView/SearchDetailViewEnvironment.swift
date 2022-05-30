//
//  SearchDetailViewEnvironment.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation
import ComposableArchitecture

struct SearchDetailViewEnvironment {
    var githubRepository = GithubRepository(networkManager: DefaultNetworkManager(networkLoader: DefaultNetworkLoader(session: .shared)))
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
