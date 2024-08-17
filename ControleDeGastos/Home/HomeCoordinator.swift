//
//  HomeCoordinator.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 11/08/24.
//

import Foundation
import UIKit

class HomeCoordinator {
    private var window: UIWindow?
    
    let feedNavigator = UINavigationController()
    let spentNavigator = UINavigationController()
    var homeViewController = HomeViewController()

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigator)
        feedCoordinator.start()
        
        let spentCoordinator = SpentCoordinator(
            navigationController: spentNavigator,
            parentCoordinator: self
        )
        spentCoordinator.start()
        
        homeViewController.setViewControllers([feedNavigator, spentNavigator], animated: true)
        window?.rootViewController = homeViewController
    }
    
    func goToFeed() {
        homeViewController.selectedViewController = feedNavigator
    }
}
