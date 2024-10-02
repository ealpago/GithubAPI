//
//  MockSearchHistoryViewController.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 2.10.2024.
//

@testable import GithubAPI

final class MockSearchHistoryViewController: SearchHistoryViewInterface {

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedPushVC = false
    var invokedPushVCCount = 0
    var invokedPushVCParameters: (userName: String, Void)?
    var invokedPushVCParametersList = [(userName: String, Void)]()

    func pushVC(userName: String) {
        invokedPushVC = true
        invokedPushVCCount += 1
        invokedPushVCParameters = (userName, ())
        invokedPushVCParametersList.append((userName, ()))
    }

    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (title: String, message: String, buttonTitle: String)?
    var invokedShowErrorParametersList = [(title: String, message: String, buttonTitle: String)]()
    var shouldInvokeShowErrorCompletion = false

    func showError(title: String, message: String, buttonTitle: String, completion: @escaping()->()) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (title, message, buttonTitle)
        invokedShowErrorParametersList.append((title, message, buttonTitle))
        if shouldInvokeShowErrorCompletion {
            completion()
        }
    }

    var invokedShowLoadingIndicator = false
    var invokedShowLoadingIndicatorCount = 0

    func showLoadingIndicator() {
        invokedShowLoadingIndicator = true
        invokedShowLoadingIndicatorCount += 1
    }

    var invokedHideLoadingIndicator = false
    var invokedHideLoadingIndicatorCount = 0

    func hideLoadingIndicator() {
        invokedHideLoadingIndicator = true
        invokedHideLoadingIndicatorCount += 1
    }
}
