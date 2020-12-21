//
//  TvTabBarController.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/29/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TvTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var controllers: [UIViewController] = []
        for cat in NewsCategory.allCases {
            let controller = TvViewController(cat)
            controllers.append(controller)
        }

        let tabController = self
        tabController.viewControllers = controllers

        tabController.selectedIndex = NewsCategory.allCases.map { $0.rawValue }.firstIndex(of: NewsCategory.general.rawValue) ?? 0
    }

}
