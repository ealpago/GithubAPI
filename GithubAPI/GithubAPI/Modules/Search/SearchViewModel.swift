//
//  SearchViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 28.09.2024.
//

import Foundation

protocol SearchViewModelInterface {
    func viewDidLoad()
    func checkButtonValidation()
    func searchBarDidBeginEditing()
    func searchBarEndEditing(text: String)
    func searchButtonTapped()
}

extension SearchViewModel {
    enum Constants {
        static let errorTitle = "Warning"
        static let errorMessage = "Search query is empty"
        static let erroButtonTitle = "OK"
    }
}

final class SearchViewModel {
    private weak var view: SearchViewInterface?

    init(view: SearchViewInterface?) {
        self.view = view
    }
}

extension SearchViewModel: SearchViewModelInterface {
    func searchBarDidBeginEditing() {
        view?.buttonUntouchable()
    }

    func searchBarEndEditing(text: String) {
        guard !text.isEmpty else {
            view?.buttonDeactive()
            view?.buttonUntouchable()
            view?.dismissKeyboard()
            return
        }
        view?.buttonActive()
        view?.buttonTouchable()
        view?.dismissKeyboard()
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
            view?.showError(title: Constants.errorTitle, message: Constants.errorMessage, buttonTitle: Constants.erroButtonTitle, completion: {})
            return
        }
        CoreDataManager.shared.saveUser(userName: userName)
        view?.pushVC()
    }
}
