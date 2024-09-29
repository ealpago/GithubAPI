//
//  ReposStoreManager.swift
//  GithubAPI
//
//  Created by Emre Alpago on 29.09.2024.
//

import Foundation

class ReposStoreManager {
    static let shared = ReposStoreManager()
    var repos = [GitHubRepo]()

    public func fetchRepos(user: String, page: Int, completion: @escaping([GitHubRepo])->()) {
        NetworkManager.service.request(requestRoute: .userRepos(user: user, page: page), responseModel: [GitHubRepo].self) { [weak self] repos in
            guard let self = self else {return}
            self.repos = repos
            completion(repos)
        }
    }
}
