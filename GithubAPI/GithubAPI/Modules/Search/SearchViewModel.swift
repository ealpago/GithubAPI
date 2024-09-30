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
    func searchBarDidBeginEditing()
    func searchBarEndEditing(text: String)
    func searchButtonTapped()
}

final class SearchViewModel {
   weak var view: SearchViewInterface?
}

extension SearchViewModel: SearchViewModelInterface {
    func searchBarDidBeginEditing() {
        self.view?.buttonUntouchable()
    }

    func searchBarEndEditing(text: String) {
        guard !text.isEmpty else {
            self.view?.buttonDeactive()
            self.view?.buttonUntouchable()
            self.view?.dismissKeyboard()
            return
        }
        self.view?.buttonActive()
        self.view?.buttonTouchable()
        self.view?.dismissKeyboard()
    }

    func viewDidLoad() {
        view?.prepareUI()
        view?.buttonDeactive()
    }
    
    func checkButtonValidation() {
        guard let isValid = view?.isValid, isValid else {
            view?.buttonDeactive()
            return
        }
        view?.buttonActive()
    }

    func searchButtonTapped() {
        guard let userName = view?.userName, !userName.isEmpty else {
            print("Search query is empty")
            return
        }
        CoreDataManager.shared.saveUser(userName: userName)
        self.view?.pushVC()
    }
}
