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
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeViewController = HomeViewController()
        
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigator)
        feedCoordinator.start()
        
        homeViewController.setViewControllers([feedNavigator], animated: true)

        window?.rootViewController = homeViewController
    }
}
