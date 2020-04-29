//
//  TvTabBarController.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/29/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TvTabBarController: UITabBarController {
    var settings = Settings()

    override func viewDidLoad() {
        super.viewDidLoad()

        var controllers: [UIViewController] = []
        for cat in NewsCategory.allCases {
            let controller = TvViewController()
            controller.category = cat
            controller.tabBarItem.title = cat.rawValue

            controllers.append(controller)
        }

        let tabController = self
        tabController.delegate = self
        tabController.viewControllers = controllers

        tabController.selectedIndex = NewsCategory.allCases.map { $0.rawValue }.firstIndex(of: settings.category.rawValue) ?? 0
    }
}

extension TvTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let c = viewController as? TvViewController else { return }

        settings.category = c.category
    }
}
