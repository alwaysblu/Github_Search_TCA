//
//  LinkHeader.swift
//  Github_Search_TCA
//
//  Created by 최정민 on 2022/06/02.
//

import Foundation

struct LinkHandler {
    func getLinks(response: URLResponse) -> [LinkHeader] {
        var link: String?
        var links: [LinkHeader] = []
        
        if let httpResponse = response as? HTTPURLResponse,
           let linkResponse = httpResponse.allHeaderFields["Link"] as? String {
            link = linkResponse
        }
        if let link = link {
            let linkList = link.split(separator: ",")
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
            links = linkList.map {
                LinkHeader(url: $0[0], rel: $0[1])
            }
        }
        
        return links
    }
    
    func getNextUrl(links: [LinkHeader]) -> String {
        if links.contains(where: {
            $0.rel == "next"
        }) {
            return links.filter {
                $0.rel == "next"
            }[0].url
        }
        return ""
    }
    
    func getIsFirstResult(links: [LinkHeader]) -> Bool {
        if links.contains(where: {
            $0.rel == "first"
        }) {
            return false
        } else {
            return true
        }
    }
    
    func getIsLastResult(links: [LinkHeader]) -> Bool {
        if links.contains(where: {
            $0.rel == "last"
        }) {
            return true
        } else {
            return false
        }
    }
}
