//
//  SearchHistoryTableViewCell.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with userName: String) {
        self.userNameLabel.text = userName
    }
}
