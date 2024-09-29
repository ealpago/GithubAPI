//
//  SearchHistoryViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

protocol SearchHistoryViewInterface: AnyObject, AlertPresentable{
   func prepareTableView()
}

final class SearchHistoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private lazy var viewModel = SearchHistoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension SearchHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SearchHistoryViewController: SearchHistoryViewInterface {
    func prepareTableView() {}
}
