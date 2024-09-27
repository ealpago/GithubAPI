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

        let vc1 = UINavigationController(rootViewController: SearchViewController())
        let vc2 = UINavigationController(rootViewController: SearchHistoryViewController())

        vc1.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc2.tabBarItem.image = UIImage(systemName: "clock.fill")

        vc1.title = "Home"
        vc2.title = "Coming Soon"

        tabBar.tintColor = .label

        setViewControllers([vc1, vc2], animated: true)
    }
}
