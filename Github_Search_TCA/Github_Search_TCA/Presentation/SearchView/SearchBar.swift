//
//  SearchBar.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI

struct SearchBar: View { // pullback을 이용해서 구현해보기 (문제점: 재활용이 안된다.)
    @Binding
    var searchQuery: String
    // 의존성 없애기 -> @Binding 사용 (BindableState 찾아보기)
    init(searchQuery: Binding<String>) {
        self._searchQuery = searchQuery
    }
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchQuery)
                    .disableAutocorrection(true)
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
