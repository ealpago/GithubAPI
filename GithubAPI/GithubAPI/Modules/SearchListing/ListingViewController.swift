//
//  ListingViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 26.09.2024.
//

import UIKit

protocol ListingViewInterface: AlertPresentable, ProgressIndicatorPresentable {
    func prepareTableView()
    func reloadData()
    func willDisplay()
    func popToRoot()
    func setupCollectionViewLayout(itemsPerRow: Int)
    func scrollToItem()
}

final class ListingViewController: UIViewController {
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var changeUIButton: UIButton!
    @IBOutlet private weak var sortByStarButton: UIButton!
    @IBOutlet private weak var sortByCreatedDateButton: UIButton!
    @IBOutlet private weak var sortByUpdatedDateButton: UIButton!
    @IBOutlet private weak var repoCollectionView: UICollectionView!

    var viewModel: ListingViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @IBAction private func changeUIButtonTapped() {
        viewModel.changeUI()
    }

    @IBAction private func sortByStarButtonTapped() {
        viewModel.sortByStar()
    }

    @IBAction private func sortByCreatedDateButtonTapped() {
        viewModel.sortByCreatedDate()
    }

    @IBAction private func sortByUpdatedDateButtonTapped() {
        viewModel.sortByUpdatedDate()
    }
}

extension ListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = repoCollectionView.dequeueReusableCell(withReuseIdentifier: RepoCollectionViewCell.identifier, for: indexPath) as? RepoCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.cellForItem(at: indexPath.item))
        return cell
    }
}

extension ListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("Displaying item at indexPath: \(indexPath.item)")
        viewModel.willDisplay(at: indexPath.item)
    }
}

extension ListingViewController: ListingViewInterface {
    func scrollToItem() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        repoCollectionView.scrollToItem(at: firstIndexPath, at: .top, animated: false)
    }

    func setupCollectionViewLayout(itemsPerRow: Int) {
        let layout = UICollectionViewFlowLayout()
        let totalSpacing: CGFloat = 10
        let padding: CGFloat = 20
        let availableWidth = repoCollectionView.frame.width - padding - (CGFloat(itemsPerRow - 1) * totalSpacing)
        let itemWidth = availableWidth / CGFloat(itemsPerRow)
        layout.itemSize = CGSize(width: itemWidth, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = totalSpacing
        repoCollectionView.collectionViewLayout = layout
    }

    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func prepareTableView() {
        repoCollectionView.dataSource = self
        repoCollectionView.delegate = self
        repoCollectionView.register(RepoCollectionViewCell.nib, forCellWithReuseIdentifier: RepoCollectionViewCell.identifier)
    }

    func reloadData() {
        self.repoCollectionView.reloadData()
    }

    func willDisplay() {}
}
