//
//  SearchBar.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI

public struct SearchBar: View {
  @Binding
  public var searchQuery: String

  public init(searchQuery: Binding<String>) {
    self._searchQuery = searchQuery
  }

  public var body: some View {
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
