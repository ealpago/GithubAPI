//
//  SearchViewModelTest.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 2.10.2024.
//

import XCTest
@testable import GithubAPI

final class SearchViewModelTest: XCTestCase {

    private var viewModel: SearchViewModel!
    private var view: MockSearchViewController!
    private var coreDataManager: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        view = .init()
        coreDataManager = .init()
        viewModel = .init(view: view, coreDataManager: coreDataManager)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_viewDidLoad_Invoke() {
        XCTAssertFalse(view.invokedPrepareUI)
        XCTAssertFalse(view.invokedButtonDeactive)

        viewModel.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedButtonDeactive)
    }

    func test_searchButtonTapped_WithValidUserName() {
        let userName = "emre"

        XCTAssertFalse(coreDataManager.invokedSaveUser)
        XCTAssertFalse(view.invokedShowError)

        viewModel.searchButtonTapped()

        coreDataManager.saveUser(userName: userName)
        XCTAssertTrue(coreDataManager.invokedSaveUser)
        XCTAssertEqual(coreDataManager.invokedSaveUserParameters?.userName, userName)
        
    }

    func test_searchButtonTapped_WithoutValidUserName() {
        let userName = ""

        XCTAssertFalse(view.invokedShowError)
        XCTAssertFalse(coreDataManager.invokedSaveUser)

        viewModel.searchButtonTapped()

        XCTAssertTrue(view.invokedShowError)
        XCTAssertFalse(coreDataManager.invokedSaveUser)
    }

    func test_searchBarDidBegin() {
        XCTAssertFalse(view.invokedButtonUntouchable)

        view.buttonUntouchable()

        XCTAssertTrue(view.invokedButtonUntouchable)
    }

    func test_SearchBarEditing_WithText() {
        let nonEmptyText = "SomeText"

        XCTAssertFalse(view.invokedButtonActive)
        XCTAssertFalse(view.invokedButtonTouchable)
        XCTAssertFalse(view.invokedDismissKeyboard)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonUntouchable)
        XCTAssertFalse(view.invokedDismissKeyboard)

        viewModel.searchBarEndEditing(text: nonEmptyText)

        XCTAssertTrue(view.invokedButtonActive)
        XCTAssertTrue(view.invokedButtonTouchable)
        XCTAssertTrue(view.invokedDismissKeyboard)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonUntouchable)
    }

    func test_SearchBarEditing_WithoutText() {
        let emptyText = ""

        XCTAssertFalse(view.invokedButtonActive)
        XCTAssertFalse(view.invokedButtonTouchable)
        XCTAssertFalse(view.invokedDismissKeyboard)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonUntouchable)
        XCTAssertFalse(view.invokedDismissKeyboard)

        viewModel.searchBarEndEditing(text: emptyText)

        XCTAssertFalse(view.invokedButtonActive)
        XCTAssertFalse(view.invokedButtonTouchable)
        XCTAssertTrue(view.invokedDismissKeyboard)
        XCTAssertTrue(view.invokedButtonDeactive)
        XCTAssertTrue(view.invokedButtonUntouchable)
    }

    func test_checkButtonValidation_WithValidView() {
        XCTAssertFalse(view.invokedIsValidGetter)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonActive)

        view.stubbedIsValid = true
        viewModel.checkButtonValidation()

        XCTAssertTrue(view.invokedIsValidGetter)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertTrue(view.invokedButtonActive)
    }

    func test_checkButtonValidation_WithoutValidView() {
        XCTAssertFalse(view.invokedIsValidGetter)
        XCTAssertFalse(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonActive)

        viewModel.checkButtonValidation()

        XCTAssertTrue(view.invokedIsValidGetter)
        XCTAssertTrue(view.invokedButtonDeactive)
        XCTAssertFalse(view.invokedButtonActive)
    }
}
