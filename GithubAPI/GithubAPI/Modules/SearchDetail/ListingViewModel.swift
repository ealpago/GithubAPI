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
    func collectionViewLayout(width: CGFloat, minimumSpacing: CGFloat, columns: Int) -> CGSize
}

final class ListingViewModel {
    weak var view: ListingViewInterface?
    private var repos: [GitHubRepo] = []
    private var sortedRepos: [GitHubRepo] = []

    private func getRepos(user: String, page: Int) {
        ReposStoreManager.shared.fetchRepos(user: user, page: page) { [weak self] repos in
            guard let self = self else {return}
            self.repos = repos
            self.view?.reloadData()
        }
    }
}

extension ListingViewModel: ListingViewModelInterface {
    func collectionViewLayout(width: CGFloat, minimumSpacing: CGFloat, columns: Int) -> CGSize {
        let spaceBetweenCells = minimumSpacing * (CGFloat(columns) - 1)
        let adjustedWidth = width - spaceBetweenCells
        let width: CGFloat = adjustedWidth / CGFloat(columns)
        let height: CGFloat = width * 2
        return CGSize(width: width, height: height)
    }
    
    func changeUI() {}
    
    var numberOfRowsInSection: Int {
        sortedRepos.count
    }

    func viewDidLoad() {
        self.view?.prepareTableView()
        self.getRepos(user: view?.userName ?? "", page: 1)
    }

    func sortByStar() {}
    
    func sortByCreatedDate() {}
    
    func sortByUpdatedDate() {}

    func beginPagination(user: String, page: Int) {
        self.getRepos(user: view?.userName ?? "", page: 1)
    }
}
