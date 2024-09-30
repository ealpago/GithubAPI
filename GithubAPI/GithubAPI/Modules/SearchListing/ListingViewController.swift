//
//  ListingViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import UIKit

protocol ListingViewInterface: AnyObject, AlertPresentable, ProgressIndicatorPresentable {
    var columns: Int { get }
    var userName: String { get }

    func prepareTableView()
    func reloadData()
    func willDisplay()
    func popToRoot()
    func setupCollectionViewLayout(itemsPerRow: Int)
    func scrollToItem()
}

struct ListingViewArguments {
    var userName: String?
}

final class ListingViewController: UIViewController {
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var changeUIButton: UIButton!
    @IBOutlet private weak var sortByStarButton: UIButton!
    @IBOutlet private weak var sortByCreatedDateButton: UIButton!
    @IBOutlet private weak var sortByUpdatedDateButton: UIButton!
    @IBOutlet private weak var repoCollectionView: UICollectionView!

    private lazy var viewModel = ListingViewModel()
    var arguments: ListingViewArguments?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @IBAction private func changeUIButtonTapped(_ sender: UIButton) {
        viewModel.changeUI()
    }

    @IBAction private func sortByStarButtonTapped(_ sender: UIButton) {
        viewModel.sortByStar()
    }
    @IBAction private func sortByCreatedDateButtonTapped(_ sender: UIButton) {
        viewModel.sortByCreatedDate()
    }
    @IBAction private func sortByUpdatedDateButtonTapped(_ sender: UIButton) {
        viewModel.sortByUpdatedDate()
    }
}

extension ListingViewController: ListingViewInterface {
    func scrollToItem() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        repoCollectionView.scrollToItem(at: firstIndexPath, at: .top, animated: false)
    }

    func setupCollectionViewLayout(itemsPerRow: Int) {
        let layout = UICollectionViewFlowLayout()

        // Calculate item width based on the number of items per row
        let totalSpacing: CGFloat = 10  // Space between items
        let padding: CGFloat = 20  // Padding on the sides
        let availableWidth = repoCollectionView.frame.width - padding - (CGFloat(itemsPerRow - 1) * totalSpacing)
        let itemWidth = availableWidth / CGFloat(itemsPerRow)

        layout.itemSize = CGSize(width: itemWidth, height: 100)  // Fixed height
        layout.minimumLineSpacing = 10  // Space between rows
        layout.minimumInteritemSpacing = totalSpacing  // Space between items
        repoCollectionView.collectionViewLayout = layout
    }

    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    var userName: String {
        arguments?.userName ?? ""
    }

    var columns: Int {
        1
    }

    func prepareTableView() {
        repoCollectionView.dataSource = self
        repoCollectionView.delegate = self
        repoCollectionView.register(RepoCollectionViewCell.nib, forCellWithReuseIdentifier: RepoCollectionViewCell.identifier)
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.repoCollectionView.reloadData()
        }
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
        guard let cell = repoCollectionView.dequeueReusableCell(withReuseIdentifier: RepoCollectionViewCell.identifier, for: indexPath) as? RepoCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.cellForItem(at: indexPath.item))
        return cell
    }
}
