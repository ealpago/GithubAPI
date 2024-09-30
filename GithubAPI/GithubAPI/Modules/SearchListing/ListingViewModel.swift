//
//  ListingViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 29.09.2024.
//

import Foundation

protocol ListingViewModelInterface {
    var view: ListingViewInterface? { get set }
    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func beginPagination(user: String, page: Int)
    func changeUI()
    func sortByStar()
    func sortByCreatedDate()
    func sortByUpdatedDate()
    func clearSorting()
    func collectionViewLayout(width: CGFloat, minimumSpacing: CGFloat, columns: Int) -> CGSize
    func cellForItem(at item: Int) -> String
}

enum SortedCases {
    case sortByStar
    case sortByDate
    case sortByUpdate
    case clean
}

final class ListingViewModel {
    weak var view: ListingViewInterface?
    private var repos: [GitHubRepo] = []
    private var sortedRepos: [GitHubRepo] = []
    private var itemsPerRow = 1
    private var selectedSortCase: SortedCases?

    private func getRepos(user: String, page: Int) {
        view?.showLoadingIndicator()
        ReposStoreManager.shared.fetchRepos(user: user, page: page) { [weak self] result in
            guard let self = self else { return }
            view?.hideLoadingIndicator()
            switch result {
            case .success(let repos):
                DispatchQueue.main.async {
                    self.repos = repos
                    self.sortedRepos = repos
                    self.view?.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription, buttonTitle: "OK", completion: {
                        self.view?.popToRoot()
                    })
                }
            }
        }
    }}

extension ListingViewModel: ListingViewModelInterface {
    func clearSorting() {
        sortedRepos = repos
        selectedSortCase = .clean
        self.view?.scrollToItem()
        self.view?.reloadData()
    }
    
    func cellForItem(at item: Int) -> String {
        guard let name = sortedRepos[item].name else { return "" }
        return name
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
        self.view?.setupCollectionViewLayout(itemsPerRow: itemsPerRow)
        self.view?.scrollToItem()
        self.view?.reloadData()
    }
    
    var numberOfRowsInSection: Int {
        sortedRepos.count
    }

    func viewDidLoad() {
        self.view?.prepareTableView()
        self.view?.setupCollectionViewLayout(itemsPerRow: 1)
        self.getRepos(user: view?.userName ?? "", page: 1)
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
        self.view?.scrollToItem()
        self.view?.reloadData()
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
        self.view?.scrollToItem()
        self.view?.reloadData()
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
        self.view?.scrollToItem()
        self.view?.reloadData()
    }

    func beginPagination(user: String, page: Int) {
        self.getRepos(user: view?.userName ?? "", page: page)
    }
}
