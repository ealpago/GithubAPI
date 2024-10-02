//
//  SearchHistoryViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol SearchHistoryViewModelInterface {
    var searchHistory: [String] { get }
    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func didSelectRow(at item: Int)
    func cellForItem(at item: Int) -> String
}

final class SearchHistoryViewModel {
    private weak var view: SearchHistoryViewInterface?

    init(view: SearchHistoryViewInterface) {
        self.view = view
    }
}

extension SearchHistoryViewModel: SearchHistoryViewModelInterface {
    var searchHistory: [String] {
        CoreDataManager.shared.fetchUniqueUserNames()
    }

    var numberOfRowsInSection: Int {
        searchHistory.count
    }

    func viewDidLoad() {
        view?.prepareTableView()
        view?.reloadData()
    }

    func cellForItem(at item: Int) -> String {
        let name = searchHistory[item]
        return name
    }

    func didSelectRow(at item: Int) {
        let userName = searchHistory[item]
        view?.pushVC(userName: userName)
    }
}
