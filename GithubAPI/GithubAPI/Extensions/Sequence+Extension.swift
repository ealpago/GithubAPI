//
//  Sequence+Extension.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter {set.insert($0).inserted}
    }
}
