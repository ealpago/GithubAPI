//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

protocol SearchViewInterface: AnyObject {
    var isValid: Bool { get }

    func prepareUI()
    func endTyping()
    func performActionForListing()
    func buttonDeactive()
    func buttonActive()
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
    @IBAction private func searchButtonTapped(_ sender: UIButton) {}
}

extension SearchViewController: SearchViewInterface {
    var isValid: Bool { userSearchBar.text != nil }

    func buttonDeactive() {
        searchButton.isEnabled = false
    }

    func buttonActive() {
        searchButton.isEnabled = true
    }

    func performActionForListing() {}
    
    func endTyping() {}
    
    func prepareUI() {
        userSearchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
}
