//
//  String+Extension.swift
//  GithubAPI
//
//  Created by Emre Alpago on 28.09.2024.
//

import UIKit

extension String {
    public var storyBoard: UIStoryboard {
        UIStoryboard(name: self, bundle: nil)
    }

    public func viewController(identifier: String) -> UIViewController {
        storyBoard.instantiateViewController(withIdentifier: identifier)
    }

    public var initialViewController: UIViewController {
        storyBoard.instantiateInitialViewController()!
    }
}
