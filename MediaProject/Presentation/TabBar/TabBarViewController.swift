//
//  TabBarViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/24/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .gray
        
        let media = MediaViewController()
        let nav1 = UINavigationController(rootViewController: media)
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        let list = RecommendMovieViewController()
        let nav2 = UINavigationController(rootViewController: list)
        nav2.tabBarItem = UITabBarItem(title: "추천영화", image: UIImage(systemName: "popcorn.fill"), tag: 1)
        setViewControllers([nav1,nav2], animated: true)
    }
}
