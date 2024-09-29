//
//  ListingViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import UIKit

protocol ListingViewInterface: AnyObject, AlertPresentable {
    var columns: Int { get }
    var userName: String { get }

    func prepareTableView()
    func reloadData()
    func willDisplay()
    func showAlert()
}

struct ListingViewArguments {
    var userName: String?
}

class ListingViewController: UIViewController {
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var changeUIButton: UIButton!
    @IBOutlet private weak var sortByStarButton: UIButton!
    @IBOutlet private weak var sortByCreatedDateButton: UIButton!
    @IBOutlet private weak var sortByUpdatedDateButton: UIButton!
    @IBOutlet private weak var reposCollectionView: UICollectionView!

    private lazy var viewModel = ListingViewModel()
    var arguments: ListingViewArguments?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @IBAction private func changeUIButtonTapped(_ sender: UIButton) {}
    @IBAction private func sortByStarButtonTapped(_ sender: UIButton) {}
    @IBAction private func sortByCreatedDateButtonTapped(_ sender: UIButton) {}
    @IBAction private func sortByUpdatedDateButtonTapped(_ sender: UIButton) {}
}

extension ListingViewController: ListingViewInterface {
    var userName: String {
        arguments?.userName ?? ""
    }
    
    var columns: Int {
        0
    }
    
    func showAlert() {
        showError(title: "", message: "", buttonTitle: "") {}
    }

    func prepareTableView() {
        reposCollectionView.dataSource = self
        reposCollectionView.delegate = self
        reposCollectionView.register(RepoCollectionViewCell.nib, forCellWithReuseIdentifier: RepoCollectionViewCell.identifier)
        reposCollectionView.reloadData()
    }
    
    func reloadData() {
        self.reposCollectionView.reloadData()
    }

    func willDisplay() {}
}

extension ListingViewController: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.beginPagination(user: "", page: 0)
    }
}

extension ListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reposCollectionView.dequeueReusableCell(withReuseIdentifier: RepoCollectionViewCell.identifier, for: indexPath) as? RepoCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension ListingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return viewModel.collectionViewLayout(width: collectionView.bounds.width, minimumSpacing: flowLayout.minimumInteritemSpacing, columns: columns)
    }
}
