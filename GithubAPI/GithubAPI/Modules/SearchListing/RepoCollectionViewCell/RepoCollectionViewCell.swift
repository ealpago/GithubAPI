//
//  RepoCollectionViewCell.swift
//  GithubAPI
//
//  Created by Emre Alpago on 29.09.2024.
//

import UIKit

final class RepoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var repoNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with repoName: String) {
         self.repoNameLabel.text = repoName
     }
}
