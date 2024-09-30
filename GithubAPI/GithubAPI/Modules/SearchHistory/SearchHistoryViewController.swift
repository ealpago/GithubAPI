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
        viewModel.numberOfRowsInSection
    }
}

//Defible
extension SearchHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.identifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.cellForItem(at: indexPath.item))
        return cell
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
}
