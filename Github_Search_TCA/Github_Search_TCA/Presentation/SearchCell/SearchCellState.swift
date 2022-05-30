//
//  SearchCellState.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import Foundation

struct SearchCellState: Equatable, Identifiable {
    let imageUrl: String
    let userName: String
    let id: UUID?
    var detail = SearchDetailViewState()
}
