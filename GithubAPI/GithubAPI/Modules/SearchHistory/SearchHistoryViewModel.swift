//
//  SearchHistoryViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol SearchHistoryViewModelInterface {

    func viewDidLoad()
    func didSelectItem()
}

final class SearchHistoryViewModel {
    weak var view: SearchHistoryViewInterface?
}


extension SearchHistoryViewModel: SearchHistoryViewModelInterface {
    func viewDidLoad() {}

    func didSelectItem() {}
}
