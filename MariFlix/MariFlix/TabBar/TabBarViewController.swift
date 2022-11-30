//
//  TabBarViewController.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//
        self.tabBar.unselectedItemTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.tabBar.backgroundColor = .black
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = UIColor(red: 3, green: 3, blue: 3, alpha: 1)
        
        self.setUptabBarItems()
    }

    // MARK: - TABBAR

    func setUptabBarItems() {
    
        //cria uma navegation controller e coloca a view controller (tela principal) dentro da navegation
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        homeNavigationController.tabBarItem = homeTabBarItem
        
        
        let myListViewController = UINavigationController(rootViewController: MyListViewController())
        let myListTabBarItem = UITabBarItem(title: "My List", image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
        myListViewController.tabBarItem = myListTabBarItem
        
        
        self.viewControllers = [homeNavigationController ,myListViewController] //array que a tabbar recebe para inicializar
    }

}
