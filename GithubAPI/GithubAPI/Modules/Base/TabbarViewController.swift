//
//  TabbarViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

extension TabbarViewController {
    enum Constants {
        static let searchStoryboardFileName = "SearchStoryboard"
        static let searchNavBar = "SearchNavBar"
        static let searchHistoryStoryboardFileName = "SearchHistoryStoryboard"
        static let searchHistoryNavBar = "SearchHistoryNavBar"
        static let searchVCTabbarImage = "magnifyingglass"
        static let searchHistoryVCTabbarImage = "clock.fill"
        static let searchVCTitle = "Home"
        static let searchHistoryVCTitle = "Search History"
    }
}

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchStoryboard = UIStoryboard(name: Constants.searchStoryboardFileName, bundle: nil)
        let searchVC = searchStoryboard.instantiateViewController(withIdentifier: Constants.searchNavBar)

        let searchHistoryStoryboard = UIStoryboard(name: Constants.searchHistoryStoryboardFileName, bundle: nil)
        let searchHistoryVC = searchHistoryStoryboard.instantiateViewController(withIdentifier: Constants.searchHistoryNavBar)

        searchVC.tabBarItem.image = UIImage(systemName: Constants.searchVCTabbarImage)
        searchHistoryVC.tabBarItem.image = UIImage(systemName: Constants.searchHistoryVCTabbarImage)

        searchVC.title = Constants.searchVCTitle
        searchHistoryVC.title = Constants.searchHistoryVCTitle

        tabBar.tintColor = .label

        setViewControllers([searchVC, searchHistoryVC], animated: true)
    }
}
