//
//  SearchViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 28.09.2024.
//

import Foundation

protocol SearchViewModelInterface {
    var view: SearchViewInterface? { get set }

    func viewDidLoad()
    func checkButtonValidation()
}

final class SearchViewModel {
   weak var view: SearchViewInterface?
}

extension SearchViewModel: SearchViewModelInterface {
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func checkButtonValidation() {
        guard let isValid = view?.isValid, isValid else {
            view?.buttonDeactive()
            return
        }
        view?.buttonActive()
    }
}
