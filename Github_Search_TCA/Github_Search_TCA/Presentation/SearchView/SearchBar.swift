//
//  SearchBar.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

struct SearchBar: View {
    private let store: Store<SearchState, SearchAction>
    
    init(store: Store<SearchState, SearchAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search ..", text: viewStore.binding(get: \.searchQuery,
                                                                   send: SearchAction.searchQueryChanged))
                }
                .frame(height: 40)
                .foregroundColor(.black)
                .padding(.leading, 13)
                .background(Color.init(UIColor.systemGray6))
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding(20)
        }
    }
}
