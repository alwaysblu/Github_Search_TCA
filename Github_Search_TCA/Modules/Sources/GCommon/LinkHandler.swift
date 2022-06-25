//
//  LinkHandler.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/05/31.
//

import Foundation
import GEntities

public enum LinkHandler {
  struct LinkHeader {
    var url: String
    var rel: String
  }

  public static func getInformation(response: URLResponse) -> Pagination {
    let links = getLinks(response: response)
    let nextURL = getNextUrl(links: links)
    let isFirst = getIsFirstResult(links: links)
    let isLast = getIsLastResult(links: links)
    return Pagination(nextUrl: nextURL, isFirst: isFirst, isLast: isLast)
  }

  private static func getLinks(response: URLResponse) -> [LinkHeader] {
    if let httpResponse = response as? HTTPURLResponse,
       let linkResponse = httpResponse.allHeaderFields["Link"] as? String {
      let linkList = linkResponse
        .split(separator: ",")
        .map { element -> [String] in
          var splitData = element
            .split(separator: ";")
            .map {
              $0.trimmingCharacters(in: .whitespaces)
            }
          splitData[0] = splitData[0]
            .trimmingCharacters(in: ["<", ">"])
          splitData[1] = splitData[1]
            .replacingOccurrences(of: "rel=", with: "")
            .trimmingCharacters(in: ["\""])
          return splitData
        }
        .map {
          LinkHeader(url: $0[0], rel: $0[1])
        }

      return linkList
    }

    return []
  }

  private static func getNextUrl(links: [LinkHeader]) -> String {
    let result = links.filter {
      $0.rel == "next"
    }

    if result.count == 1 {
      return result[0].url
    }

    return ""
  }

  private static func getIsFirstResult(links: [LinkHeader]) -> Bool {
    if links.contains(where: {
      $0.rel == "first"
    }) {
      return false
    }

    return true
  }

  private static func getIsLastResult(links: [LinkHeader]) -> Bool {
    if links.contains(where: {
      $0.rel == "last"
    }) {
      return true
    }

    return false
  }
}
