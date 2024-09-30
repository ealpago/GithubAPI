//
//  SearchHistoryViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol SearchHistoryViewModelInterface {
    var searchHistory: [Users] { get }
    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func didSelectItem()
    func cellForItem(at item: Int) -> String
}

final class SearchHistoryViewModel {
    weak var view: SearchHistoryViewInterface?
}

extension SearchHistoryViewModel: SearchHistoryViewModelInterface {
    var searchHistory: [Users] {
        CoreDataManager.shared.fetchUsers()
    }
    
    var numberOfRowsInSection: Int {
        searchHistory.compactMap { $0.userName }.uniqued().count
    }

    func viewDidLoad() {
        view?.prepareTableView()
        view?.reloadData()
    }

    func cellForItem(at item: Int) -> String {
        let uniqueUserNames = searchHistory.compactMap { $0.userName }.uniqued()
        guard item < uniqueUserNames.count else { return "" }
        let name = uniqueUserNames[item]
        return name
    }

    func didSelectItem() {}
}
