//
//  License.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import Foundation

struct License: Codable {

    let key: String?
    let name: String?
    let nodeId: String?
    let spdxId: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case name = "name"
        case nodeId = "node_id"
        case spdxId = "spdx_id"
        case url = "url"
    }
}
