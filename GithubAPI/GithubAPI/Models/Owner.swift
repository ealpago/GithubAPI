//
//  Owner.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import Foundation

struct Owner: Codable {

    let avatarUrl: String?
    let eventsUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let gravatarId: String?
    let htmlUrl: String?
    let id: Int?
    let login: String?
    let nodeId: String?
    let organizationsUrl: String?
    let receivedEventsUrl: String?
    let reposUrl: String?
    let siteAdmin: Bool?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let type: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case eventsUrl = "events_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case id = "id"
        case login = "login"
        case nodeId = "node_id"
        case organizationsUrl = "organizations_url"
        case receivedEventsUrl = "received_events_url"
        case reposUrl = "repos_url"
        case siteAdmin = "site_admin"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case type = "type"
        case url = "url"
    }
}
