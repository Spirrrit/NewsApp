//
//  TabBarController.swift
//  NewsApp
//
//  Created by Слава on 03.07.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar(){
        viewControllers = [generateNavVC(viewController: MainVC(),
                                      title: "Главная",
                                      image: UIImage(systemName: "house")),
                           generateNavVC(viewController: SettingsVC(),
                                      title: "Настройки",
                                      image: UIImage(systemName: "gear"))]
    }
    
    private func generateNavVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
