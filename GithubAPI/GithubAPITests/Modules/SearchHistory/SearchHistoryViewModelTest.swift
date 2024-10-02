//
//  SearchHistoryViewModelTest.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 2.10.2024.
//

import XCTest
@testable import GithubAPI

final class SearchHistoryViewModelTest: XCTest {
    private var viewModel: SearchHistoryViewModel!
    private var view: MockSearchHistoryViewController!
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

    func test_SearchHistory_FetchUser() {
        let expectedUserNames = ["user1", "user2", "user3"]
        coreDataManager.stubbedFetchUniqueUserNamesResult = expectedUserNames
        XCTAssertFalse(coreDataManager.invokedFetchUniqueUserNames)

        let searchHistory = viewModel.searchHistory

        XCTAssertTrue(coreDataManager.invokedFetchUniqueUserNames)
        XCTAssertEqual(searchHistory, expectedUserNames)
    }

    func test_numberOfRowsInSection_FromSearchHistory() {
        XCTAssertTrue(coreDataManager.invokedFetchUniqueUserNames)
        XCTAssertEqual(coreDataManager.invokedFetchUniqueUserNamesCount, 1)

        let numberOfRowsInSection = viewModel.numberOfRowsInSection

        XCTAssertTrue(coreDataManager.invokedFetchUniqueUserNames)
        XCTAssertEqual(coreDataManager.invokedFetchUniqueUserNamesCount, 2)
    }

    func test_viewDidLoad() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedReloadData)

        viewModel.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedPrepareTableView)
    }

    func test_CellForItem() {
        let mockedSearchHistory = ["Alice", "Bob", "Charlie"]

        let item0 = viewModel.cellForItem(at: 0)
        let item1 = viewModel.cellForItem(at: 1)
        let item2 = viewModel.cellForItem(at: 2)

        XCTAssertEqual(item0, viewModel.cellForItem(at: 0))
        XCTAssertEqual(item1, viewModel.cellForItem(at: 1))
        XCTAssertEqual(item2, viewModel.cellForItem(at: 2))
    }

    func test_DidSelectRow() {
        let mockedSearchHistory = ["Alice"]

        viewModel.didSelectRow(at: 0)

        XCTAssertEqual(view.invokedPushVCCount, 1)
    }
}
