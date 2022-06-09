//
//  SearchCellEnvironment.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/29.
//

import Foundation
import ComposableArchitecture

struct SearchCellEnvironment {
    let githubRepository: GithubRepository
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
