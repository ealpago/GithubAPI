//
//  MockListingViewController.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 3.10.2024.
//

@testable import GithubAPI

final class MockListingViewController: ListingViewInterface {

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

    var invokedWillDisplay = false
    var invokedWillDisplayCount = 0

    func willDisplay() {
        invokedWillDisplay = true
        invokedWillDisplayCount += 1
    }

    var invokedPopToRoot = false
    var invokedPopToRootCount = 0

    func popToRoot() {
        invokedPopToRoot = true
        invokedPopToRootCount += 1
    }

    var invokedSetupCollectionViewLayout = false
    var invokedSetupCollectionViewLayoutCount = 0
    var invokedSetupCollectionViewLayoutParameters: (itemsPerRow: Int, Void)?
    var invokedSetupCollectionViewLayoutParametersList = [(itemsPerRow: Int, Void)]()

    func setupCollectionViewLayout(itemsPerRow: Int) {
        invokedSetupCollectionViewLayout = true
        invokedSetupCollectionViewLayoutCount += 1
        invokedSetupCollectionViewLayoutParameters = (itemsPerRow, ())
        invokedSetupCollectionViewLayoutParametersList.append((itemsPerRow, ()))
    }

    var invokedScrollToItem = false
    var invokedScrollToItemCount = 0

    func scrollToItem() {
        invokedScrollToItem = true
        invokedScrollToItemCount += 1
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

