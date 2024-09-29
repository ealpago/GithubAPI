//
//  NetworkService.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkRouter {
    case userRepos(user: String, page: Int)

    public var method: HTTPMethod {
        switch self {
        case .userRepos(user: let user, page: let page):
            return .get
        }
    }

    public var path: String {
        switch self {
        case .userRepos(user: let user, page: let page):
            return APIConstants.shared.githubBaseURL + "users/\(user)/repos?type=owner&page=\(page)&per_page=10"
        }
    }
}

class NetworkManager {
    static let service = NetworkManager()
    public func request<T: Codable>(requestRoute: NetworkRouter, responseModel:T.Type, completion:@escaping (_ details: T) -> Void) {
        guard let url = URL(string: requestRoute.path) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = requestRoute.method.rawValue
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                let data = try JSONDecoder().decode(T.self, from: data!)
                completion(data)
            } catch let e as NSError {
                print("error : \(e)")
            }
        }
        task.resume()
    }
}
