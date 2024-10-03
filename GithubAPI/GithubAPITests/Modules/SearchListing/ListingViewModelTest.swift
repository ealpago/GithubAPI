//
//  ListingViewModelTest.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 3.10.2024.
//

import XCTest
@testable import GithubAPI

final class ListingViewModelTest: XCTest {
    private var viewModel: ListingViewModel!
    private var view: MockListingViewController!
    private var networkManager: MockNetworkManager!
    private var arguments: ListingViewArguments!

    override func setUp() {
        super.setUp()
        view = .init()
        arguments = .init()
        viewModel = .init(view: view, arguments: arguments)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_ViewDidLoad() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedSetupCollectionViewLayout)
        XCTAssertFalse(view.invokedShowLoadingIndicator)
        XCTAssertFalse(networkManager.invokedRequest)
        XCTAssertFalse(view.invokedHideLoadingIndicator)
        XCTAssertFalse(view.invokedReloadData)

        viewModel.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedSetupCollectionViewLayout)
        XCTAssertTrue(view.invokedShowLoadingIndicator)
        XCTAssertTrue(networkManager.invokedRequest)
        XCTAssertTrue(view.invokedHideLoadingIndicator)
        XCTAssertTrue(view.invokedReloadData)
    }

    func test_ClearSorting() {
        XCTAssertFalse(view.invokedScrollToItem)
        XCTAssertFalse(view.invokedReloadData)

        viewModel.clearSorting()

        XCTAssertTrue(view.invokedScrollToItem)
        XCTAssertTrue(view.invokedReloadData)
    }

    func test_CellForItem() {
        let mockedSortedRepos = ["Alice", "Bob", "Charlie"]

        let item0 = viewModel.cellForItem(at: 0)
        let item1 = viewModel.cellForItem(at: 1)
        let item2 = viewModel.cellForItem(at: 2)

        XCTAssertEqual(item0, viewModel.cellForItem(at: 0))
        XCTAssertEqual(item1, viewModel.cellForItem(at: 1))
        XCTAssertEqual(item2, viewModel.cellForItem(at: 2))
    }

    func test_ChangeUI() {
        XCTAssertFalse(view.invokedSetupCollectionViewLayout)
        XCTAssertFalse(view.invokedScrollToItem)
        XCTAssertFalse(view.invokedReloadData)

        viewModel.changeUI()

        XCTAssertTrue(view.invokedSetupCollectionViewLayout)
        XCTAssertTrue(view.invokedScrollToItem)
        XCTAssertTrue(view.invokedReloadData)
    }
}
