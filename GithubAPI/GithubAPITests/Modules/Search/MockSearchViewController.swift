//
//  MockSearchViewController.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 2.10.2024.
//

@testable import GithubAPI

final class MockSearchViewController: SearchViewInterface {

    var invokedIsValidGetter = false
    var invokedIsValidGetterCount = 0
    var stubbedIsValid: Bool! = false

    var isValid: Bool {
        invokedIsValidGetter = true
        invokedIsValidGetterCount += 1
        return stubbedIsValid
    }

    var invokedUserNameGetter = false
    var invokedUserNameGetterCount = 0
    var stubbedUserName: String! = ""

    var userName: String {
        invokedUserNameGetter = true
        invokedUserNameGetterCount += 1
        return stubbedUserName
    }

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedButtonDeactive = false
    var invokedButtonDeactiveCount = 0

    func buttonDeactive() {
        invokedButtonDeactive = true
        invokedButtonDeactiveCount += 1
    }

    var invokedButtonActive = false
    var invokedButtonActiveCount = 0

    func buttonActive() {
        invokedButtonActive = true
        invokedButtonActiveCount += 1
    }

    var invokedButtonTouchable = false
    var invokedButtonTouchableCount = 0

    func buttonTouchable() {
        invokedButtonTouchable = true
        invokedButtonTouchableCount += 1
    }

    var invokedButtonUntouchable = false
    var invokedButtonUntouchableCount = 0

    func buttonUntouchable() {
        invokedButtonUntouchable = true
        invokedButtonUntouchableCount += 1
    }

    var invokedPushVC = false
    var invokedPushVCCount = 0
    func pushVC() {
        invokedPushVC = true
        invokedPushVCCount += 1
    }

    var invokedDismissKeyboard = false
    var invokedDismissKeyboardCount = 0

    func dismissKeyboard() {
        invokedDismissKeyboard = true
        invokedDismissKeyboardCount += 1
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
}
