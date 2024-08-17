//
//  spentedCoordinator.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import UIKit

class SpentCoordinator {
    private var navigationController: UINavigationController
    private var parentCoordinator: HomeCoordinator
    
    init(navigationController: UINavigationController, parentCoordinator: HomeCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let spentViewController = SpentViewController()
        spentViewController.viewModel = SpentViewModel(
            interactor: SpentInteractor(),
            coordinator: self
        )
        
        navigationController.pushViewController(spentViewController, animated: true)
    }
    
    func goToFeed() {
        parentCoordinator.goToFeed()
    }
}
