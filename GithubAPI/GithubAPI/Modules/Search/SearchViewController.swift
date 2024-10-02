//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit
import CoreData

protocol SearchViewInterface: AlertPresentable {
    var isValid: Bool { get }
    var userName: String { get }

    func prepareUI()
    func buttonDeactive()
    func buttonActive()
    func buttonTouchable()
    func buttonUntouchable()
    func pushVC()
    func dismissKeyboard()
}

extension SearchViewController {
    enum Constants {
        static let listingStoryboardFileName = "ListingStoryboard"
    }
}

final class SearchViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var githubLogoImageView: UIImageView!
    @IBOutlet private weak var userSearchBar: UISearchBar!
    @IBOutlet private weak var searchButton: UIButton!

    //MARK: Properties
    private lazy var viewModel = SearchViewModel(view: self)

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    //MARK: Actions
    @IBAction private func searchButtonTapped() {
        viewModel.searchButtonTapped()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing() {
        viewModel.searchBarDidBeginEditing()
    }

    func searchBarSearchButtonClicked() {
        viewModel.searchBarEndEditing(text: userName)
    }
}

extension SearchViewController: SearchViewInterface {
    var userName: String {
        userSearchBar.text ?? ""
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

    func dismissKeyboard() {
        userSearchBar.resignFirstResponder()
    }

    func pushVC() {
        if let vc = Constants.listingStoryboardFileName.viewController(identifier: ListingViewController.identifier) as? ListingViewController {
            vc.arguments = ListingViewArguments(userName: userName)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
