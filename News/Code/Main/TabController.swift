//
//  TabController.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .lightGray
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        let newsVC = NewsVC()
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "list.bullet"), tag: 0)

        let favNewsVC = FavoriteNewsVC()
        favNewsVC.tabBarItem = UITabBarItem(title: "Favorite News", image: UIImage(systemName: "star.fill"), tag: 1)

        let newsNavController = UINavigationController(rootViewController: newsVC)
        let favNewsNavController = UINavigationController(rootViewController: favNewsVC)

        self.setViewControllers([newsNavController, favNewsNavController], animated: true)
    }
}
