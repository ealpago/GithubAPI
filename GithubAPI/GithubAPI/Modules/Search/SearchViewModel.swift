//
//  SearchViewModel.swift
//  GithubAPI
//
//  Created by Emre Alpago on 28.09.2024.
//

import Foundation

//MARK: SearchViewModelInterface
protocol SearchViewModelInterface {
    func viewDidLoad()
    func searchButtonTapped()
    func searchBarDidBeginEditing()
    func searchBarEndEditing(text: String)
    func checkButtonValidation()
}

//MARK: SearchViewModelExtension
extension SearchViewModel {
    enum Constants {
        static let errorTitle = "Warning"
        static let errorMessage = "Search query is empty"
        static let erroButtonTitle = "OK"
    }
}

//MARK: SearchViewModel
final class SearchViewModel {
    private weak var view: SearchViewInterface?
    private let coreDataManager: CoreDataManagerInterface

    init(view: SearchViewInterface?, coreDataManager: CoreDataManagerInterface = CoreDataManager.shared) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
}

//MARK: SearchViewModelInterfaceExtension
extension SearchViewModel: SearchViewModelInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.buttonDeactive()
    }

    func searchButtonTapped() {
        guard let userName = view?.userName, !userName.isEmpty else {
            view?.showError(title: Constants.errorTitle, message: Constants.errorMessage, buttonTitle: Constants.erroButtonTitle, completion: {})
            return
        }
        CoreDataManager.shared.saveUser(userName: userName)
        view?.pushVC()
    }

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

    func checkButtonValidation() {
        guard let isValid = view?.isValid, isValid else {
            view?.buttonDeactive()
            return
        }
        view?.buttonActive()
    }
}
