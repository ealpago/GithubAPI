//
//  TabbarViewController.swift
//  GithubAPI
//
//  Created by Emre Alpago on 27.09.2024.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchStoryboard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        let searchVC = searchStoryboard.instantiateViewController(withIdentifier: "SearchNavBar")

        let searchHistoryStoryboard = UIStoryboard(name: "SearchHistoryStoryboard", bundle: nil)
        let searchHistoryVC = searchHistoryStoryboard.instantiateViewController(withIdentifier: "SearchHistoryNavBar")

        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchHistoryVC.tabBarItem.image = UIImage(systemName: "clock.fill")

        searchVC.title = "Home"
        searchHistoryVC.title = "Coming Soon"

        tabBar.tintColor = .label

        setViewControllers([searchVC, searchHistoryVC], animated: true)
    }
}
