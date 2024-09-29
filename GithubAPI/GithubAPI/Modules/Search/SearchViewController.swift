//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit
import CoreData

protocol SearchViewInterface: AnyObject, AlertPresentable {
    var isValid: Bool { get }
    var userName: String { get }

    func prepareUI()
    func buttonDeactive()
    func buttonActive()
    func buttonTouchable()
    func buttonUntouchable()
    func pushVC()
    func showAlert()
    func dismissKeyboard()
}

final class SearchViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var githubLogoImageView: UIImageView!
    @IBOutlet private weak var userSearchBar: UISearchBar!
    @IBOutlet private weak var searchButton: UIButton!

    //MARK: Properties
    private lazy var viewModel = SearchViewModel()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    //MARK: Actions
    @IBAction private func searchButtonTapped(_ sender: UIButton) {
        viewModel.searchButtonTapped()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchBarDidBeginEditing()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarEndEditing(text: userName)
    }
}

extension SearchViewController: SearchViewInterface {
    var userName: String {
        get {
            return userSearchBar.text ?? ""
        }
    }

    var isValid: Bool { userSearchBar.text != nil }

    func prepareUI() {
        userSearchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        userSearchBar.searchTextField.returnKeyType = .done
        userSearchBar.delegate = self
    }

    func buttonDeactive() {
        searchButton.isEnabled = false
    }

    func buttonActive() {
        searchButton.isEnabled = true
    }
    
    func buttonTouchable() {
        searchButton.isUserInteractionEnabled = true
    }

    func buttonUntouchable() {
        searchButton.isUserInteractionEnabled = false
    }

    func showAlert() {
        showError(title: "", message: "", buttonTitle: "") {}
    }

    func dismissKeyboard() {
        userSearchBar.resignFirstResponder()
    }

    func pushVC() {
        if let vc = "ListingStoryboard".viewController(identifier: ListingViewController.identifier) as? ListingViewController {
            vc.arguments = ListingViewArguments(userName: userName)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
