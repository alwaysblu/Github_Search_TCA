//
//  URLResponse+Extension.swift
//  onboardingApp
//
//  Created by 최정민 on 2022/06/09.
//

import Foundation

extension URLResponse {
    func getPagination() -> Pagination {
        return LinkHandler.getInformation(response: self)
    }
}
