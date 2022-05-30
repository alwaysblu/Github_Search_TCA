//
//  SearchEnvironment.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

struct SearchEnvironment {
    var githubRepository: GithubRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
