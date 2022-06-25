//
//  SearchDetailView.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/27.
//

import SwiftUI
import GEntities

public struct SearchDetailView: View { // #08 : 그냥 뷰로 변경함
  @State
  private var userDetailInformation: UserDetailInformation

  public init(userDetailInformation: UserDetailInformation) {
    self.userDetailInformation = userDetailInformation
  }

  public var body: some View { // #07 : 네트워크 호출 과정 없앰 (중복)
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        Text("profileImage: \n\(userDetailInformation.profileImage)")
        Text("githubUrl: \n\(userDetailInformation.githubUrl)")
        Text("followersUrl: \n\(userDetailInformation.followersUrl)")
        Text("followingUrl: \n\(userDetailInformation.followingUrl)")
        Text("gists_url: \n\(userDetailInformation.gistsUrl)")
        Text("starredUrl: \n\(userDetailInformation.starredUrl)")
        Text("subscriptionsUrl: \n\(userDetailInformation.subscriptionsUrl)")
        Text("organizationsUrl: \n\(userDetailInformation.organizationsUrl)")
        Text("reposUrl: \n\(userDetailInformation.reposUrl)")
        Text("followers: \n\(userDetailInformation.followers)")
      }
    }
  }
}

public struct SearchDetailView_Previews: PreviewProvider {
  public static var previews: some View {
    SearchDetailView(userDetailInformation: UserDetailInformation.empty)
  }
}
