//
//  SearchCell.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/05/30.
//

import SwiftUI
import ComposableArchitecture

struct SearchCell: View {
    private let store: Store<SearchCellState, SearchCellAction>
    @ObservedObject
    var viewStore: ViewStore<SearchCellState, SearchCellAction>
    
    init(store: Store<SearchCellState, SearchCellAction>) {
        self.store = store
        viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        NavigationLink(destination: SearchDetailView(store: store.scope(state: \.detail,
                                                                        action: SearchCellAction.detail))) {
            HStack {
                AsyncImage(url: URL(string: viewStore.imageUrl)!) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView().frame(width: 70, height: 70, alignment: .center)
                        .padding([.leading])
                }.frame(width: 70, height: 70, alignment: .leading)
                    .padding([.leading])
                Spacer()
                Text(viewStore.userName)
                    .padding([.trailing])
            }
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(store: Store(initialState: SearchCellState(imageUrl: "https://user-images.githubusercontent.com/75533266/170195862-bd80e93c-09f6-4167-b0ab-320936a3f19c.png",
                                                              userName: "유저 아이디",
                                                              id: UUID()),
                                reducer: searchCellReducer,
                                environment: SearchCellEnvironment()))
    }
}
