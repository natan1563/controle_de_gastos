//
//  FeedViewController.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 11/08/24.
//

import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationConfigs()
    }
    
    private func setupNavigationConfigs() {
        // Nav Bar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationItem.title = "Inicio"
        
        // Tab Bar
        navigationController?.title = "Inicio"
        navigationController?.tabBarItem.image = UIImage(systemName: "house")
    }
}
