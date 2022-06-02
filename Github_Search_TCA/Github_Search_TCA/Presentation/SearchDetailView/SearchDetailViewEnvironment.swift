//
//  SearchDetailViewEnvironment.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation
import ComposableArchitecture

struct SearchDetailViewEnvironment {
    var githubRepository =
    GithubRepository(networkManager:
                        DefaultNetworkManager(networkLoader:
                                                DefaultNetworkLoader(session: .shared)
                                             )
    )
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
