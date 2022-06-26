//
//  SearchCell.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/25.
//

import SwiftUI
import GCommon
import GSearchDetail
import ComposableArchitecture

public struct SearchCell: View {
  private let store: Store<SearchCellState, SearchCellAction>
  @ObservedObject
  private var viewStore: ViewStore<SearchCellState, SearchCellAction>

  public init(store: Store<SearchCellState, SearchCellAction>) {
    self.store = store
    viewStore = ViewStore(self.store)
  }

  public var body: some View {
    NavigationLink(destination: SearchDetailView(userDetailInformation: viewStore.userDetailInformation)) {
      HStack {
        AsyncImage(url: URL(string: viewStore.imageUrl)!) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
            .frame(width: 70, height: 70, alignment: .center)
            .padding([.leading])
        }
        .frame(width: 70, height: 70, alignment: .leading)
        .padding([.leading])
        Spacer()
        VStack(alignment: .trailing, spacing: 10) {
          Text(viewStore.userName)
            .padding([.trailing])
          Text("followers: \(viewStore.userDetailInformation.followers)")
            .padding([.trailing])
        }
      }
    }.onAppear { // #06 : followers 추가함
      viewStore.send(.requestUserDetailInformation)
    }
  }
}

public struct SearchCell_Previews: PreviewProvider {
  public static var previews: some View {
    SearchCell(store:
                Store(
                  initialState: SearchCellState(
                    imageUrl: "https://user-images.githubusercontent.com/75533266/170195862-bd80e93c-09f6-4167-b0ab-320936a3f19c.png",
                    userName: "유저 아이디",
                    id: UUID()
                  ),
                  reducer: searchCellReducer,
                  environment: .mock
                )
    )
  }
}
