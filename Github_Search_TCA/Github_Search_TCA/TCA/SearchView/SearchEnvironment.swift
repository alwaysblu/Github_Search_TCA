//
//  SearchEnvironment.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI
import ComposableArchitecture

struct SearchEnvironment {
    var githubRepository: GithubRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var cellEnvironment: SearchCellEnvironment
    var emptyUserDetailInformation: UserDetailInformation
}
