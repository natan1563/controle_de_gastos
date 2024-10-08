//
//  FeedCoordinator.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 11/08/24.
//

import UIKit

class FeedCoordinator {
    private var navigationController: UINavigationController
    var navigationParent: UINavigationController?
    
    init(navigationController: UINavigationController, navigationParent: UINavigationController? = nil) {
        self.navigationController = navigationController
        self.navigationParent = navigationParent
    }
    
    func start() {
        let feedViewModel = FeedViewModel(interactor: FeedInteractor())
        let feedViewController = FeedViewController()
        feedViewController.viewModel = feedViewModel

        navigationController.pushViewController(feedViewController, animated: true)
    }
}
