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

    func fetchRepos(user: String, page: Int, completion: @escaping (Result<[GitHubRepo], NetworkError>) -> ()) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.userRepos(user: user, page: page), responseModel: [GitHubRepo].self) { [weak self] result in
            switch result {
            case .success(let repos):
                print("Received repos: \(repos)")
                self?.repos = repos
                completion(.success(repos))
            case .failure(let error):
                print("Failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
