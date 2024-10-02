//
//  MockNetworkManager.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 3.10.2024.
//

@testable import GithubAPI

final class MockNetworkManager: NetworkManagerInterface {

    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (requestRoute: NetworkRouter, responseModel: Any)?
    var invokedRequestParametersList = [(requestRoute: NetworkRouter, responseModel: Any)]()
    var stubbedRequestCompletionResult: (Result<T, NetworkError>, Void)?

    func request<T: Codable>(requestRoute: NetworkRouter, responseModel: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (requestRoute, responseModel)
        invokedRequestParametersList.append((requestRoute, responseModel))
        if let result = stubbedRequestCompletionResult {
            completion(result.0)
        }
    }
}
