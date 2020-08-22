//
//  TabBarController.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import UIKit

enum TabType {
    case search, favorites

    var system: UITabBarItem.SystemItem {
        switch self {
        case .search:   return .search
        case .favorites: return .favorites
        }
    }

    var tag: Int {
        switch self {
        case .search:    return 0
        case .favorites: return 1
        }
    }
}

class TabBarController: UITabBarController {

    private let types: [TabType]

    private let controllers: [UIViewController]

    init() {
        self.types = [.search, .favorites]
        self.controllers = types.map(TabBarController.prepareController(type:))
        super.init(nibName: nil, bundle: nil)
        setViewControllers(self.controllers, animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarController {

    func setupTabBar() {
        tabBar.barStyle = .default
        tabBar.isTranslucent = false
        tabBar.tintColor = .barItemBlue
    }
}

extension TabBarController {

    static func prepareController(type: TabType) -> UIViewController {
        let controller: UIViewController
        switch type {
        case .search:
            controller = InputController()
        case .favorites:
            controller = FavoriteListController()
        }
        let tabBar = UITabBarItem(tabBarSystemItem: type.system, tag: type.tag)
        controller.tabBarItem = tabBar
        return UINavigationController(rootViewController: controller)
    }
}
