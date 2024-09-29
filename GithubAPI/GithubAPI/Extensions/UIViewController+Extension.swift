//
//  UIViewController+Extension.swift
//  GithubAPI
//
//  Created by Emre Alpago on 29.09.2024.
//

import UIKit

extension UIViewController {
    public static var bundle: Bundle {
        get {
            Bundle(for: self)
        }
    }

    public static var identifier: String {
        String(describing: self)
    }

    public static var nib: UINib {
        get {
            UINib(nibName: identifier, bundle: bundle)
        }
    }
}
