//
//  SearchHistoryViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

protocol SearchHistoryViewInterface: AnyObject, AlertPresentable, ProgressIndicatorPresentable {
    func prepareTableView()
    func reloadData()
    func pushVC(userName: String)
}

final class SearchHistoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private lazy var viewModel = SearchHistoryViewModel(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
}

extension SearchHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.identifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.cellForItem(at: indexPath.item))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}

extension SearchHistoryViewController: SearchHistoryViewInterface {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchHistoryTableViewCell.nib, forCellReuseIdentifier: SearchHistoryTableViewCell.identifier)
    }
    
    func pushVC(userName: String) {
        if let vc = "ListingStoryboard".viewController(identifier: ListingViewController.identifier) as? ListingViewController {
            vc.viewModel = ListingViewModel(view: vc, arguments: ListingViewArguments(userName: userName))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
