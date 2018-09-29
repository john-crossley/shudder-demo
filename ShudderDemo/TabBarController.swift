//
//  TabBarController.swift
//  ShudderDemo
//
//  Created by John Crossley on 29/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [UINavigationController(rootViewController: makeFeaturedController())]
    }

    private func makeFeaturedController() -> UIViewController {
        let viewModel = FeaturedViewModel(service: ShudderMovieService())
        let controller = FeaturedViewController(with: viewModel)
        controller.tabBarItem = UITabBarItem(title: "Featured", image: UIImage(named: "star"), tag: 0)

        return controller
    }
}
