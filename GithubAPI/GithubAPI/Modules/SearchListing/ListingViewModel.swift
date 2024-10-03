//
//  ListingViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 29.09.2024.
//

import Foundation

protocol ListingViewModelInterface {
    var numberOfItemsInSection: Int { get }

    func viewDidLoad()
    func changeUI()
    func sortByStar()
    func sortByCreatedDate()
    func sortByUpdatedDate()
    func clearSorting()
    func collectionViewLayout(width: CGFloat, minimumSpacing: CGFloat, columns: Int) -> CGSize
    func cellForItem(at item: Int) -> String
    func willDisplay(at index: Int)
}

struct ListingViewArguments {
    var userName: String?
}

enum SortedCases {
    case sortByStar
    case sortByDate
    case sortByUpdate
    case clean
}

final class ListingViewModel {
    private weak var view: ListingViewInterface?
    private var repos: [GitHubRepo] = []
    private var sortedRepos: [GitHubRepo] = []
    private var itemsPerRow = 1
    private var isFetching = false
    private var currentPage = 1
    private var totalPages = 1
    private var selectedSortCase: SortedCases?
    private var networkManager: NetworkManager
    private var arguments: ListingViewArguments

    init(view: ListingViewInterface, arguments: ListingViewArguments, networkManager: NetworkManager = NetworkManager.shared){
        self.view = view
        self.arguments = arguments
        self.networkManager = networkManager
    }

    private func getUserRepos(user: String, page: Int) {
        self.isFetching = true
        view?.showLoadingIndicator()
        networkManager.request(requestRoute: NetworkRouter.userRepos(user: user, page: page), responseModel: [GitHubRepo].self) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideLoadingIndicator()
            switch result {
            case .success(let repos):
                self.repos.append(contentsOf: repos)
                self.sortedRepos.append(contentsOf: repos)
                self.view?.reloadData()
                self.isFetching = false
            case .failure(let error):
                self.view?.showError(title: "Error", message: error.localizedDescription, buttonTitle: "OK", completion: {
                    self.isFetching = false
                    self.view?.popToRoot()
                })
            }
        }
    }}

extension ListingViewModel: ListingViewModelInterface {
    var numberOfItemsInSection: Int {
        sortedRepos.count
    }

    func viewDidLoad() {
        view?.prepareTableView()
        view?.setupCollectionViewLayout(itemsPerRow: 1)
        getUserRepos(user: arguments.userName ?? "", page: 1)
    }

    func clearSorting() {
        sortedRepos = repos
        selectedSortCase = .clean
        view?.scrollToItem()
        view?.reloadData()
    }

    func cellForItem(at item: Int) -> String {
        sortedRepos[item].name ?? ""
    }

    func collectionViewLayout(width: CGFloat, minimumSpacing: CGFloat, columns: Int) -> CGSize {
        let spaceBetweenCells = minimumSpacing * (CGFloat(columns) - 1)
        let adjustedWidth = width - spaceBetweenCells
        let width: CGFloat = adjustedWidth / CGFloat(columns)
        let height: CGFloat = width * 2
        return CGSize(width: width, height: height)
    }

    func changeUI() {
        itemsPerRow = itemsPerRow >= 3 ? 1 : itemsPerRow + 1
        view?.setupCollectionViewLayout(itemsPerRow: itemsPerRow)
        view?.scrollToItem()
        view?.reloadData()
    }

    func sortByStar() {
        guard selectedSortCase != .sortByStar else {
            clearSorting()
            return
        }
        selectedSortCase = .sortByStar
        sortedRepos = repos.sorted {
            guard let starOne = $0.stargazersCount, let starTwo = $1.stargazersCount else {
                return false
            }
            return starOne > starTwo
        }
        view?.scrollToItem()
        view?.reloadData()
    }

    func sortByCreatedDate() {
        guard selectedSortCase != .sortByDate else {
            clearSorting()
            return
        }
        selectedSortCase = .sortByDate
        sortedRepos = repos.sorted {
            guard let dateOne = $0.createdAt?.toDate(), let dateTwo = $1.createdAt?.toDate() else {
                return false
            }
            return dateOne > dateTwo
        }
        view?.scrollToItem()
        view?.reloadData()
    }

    func sortByUpdatedDate() {
        guard selectedSortCase != .sortByUpdate else {
            clearSorting()
            return
        }
        selectedSortCase = .sortByUpdate
        sortedRepos = repos.sorted {
            guard let dateOne = $0.updatedAt?.toDate(), let dateTwo = $1.updatedAt?.toDate() else {
                return false
            }
            return dateOne > dateTwo
        }
        view?.scrollToItem()
        view?.reloadData()
    }

    func willDisplay(at index: Int) {
        if sortedRepos.count % 10 == 0, index == sortedRepos.count - 1, !isFetching {
            currentPage += 1
            getUserRepos(user: arguments.userName ?? "", page: currentPage)
        }
    }
}
