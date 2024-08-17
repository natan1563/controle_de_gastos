//
//  FeedViewController.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 11/08/24.
//

import UIKit

class FeedViewController: UIViewController {
    private var feedItems: [FeedObject] = []
    
    let loading: LoadingComponent = {
        return LoadingComponent(style: .medium)
    }()
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Buscar"
        textField.addShadowBorder()

        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationConfigs()
        setupComponents()
        setupConstraints()
        setupDependencies()

        configureDismissKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loadData()
    }

    private func setupComponents() {
        view.addSubview(logo)
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(loading)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            textField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loading.topAnchor.constraint(equalTo: view.topAnchor),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationConfigs() {
        // Nav Bar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationItem.title = "Inicio"
        
        // Tab Bar
        navigationController?.tabBarItem.title = "Inicio"
        navigationController?.tabBarItem.image = UIImage(systemName: "house")
    }
    
    func setupDependencies() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Despesas"
    }
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remover") { (action, view, completionHandler) in
            let spent = self.feedItems[indexPath.row]
            
            if let deleted = self.viewModel?.removeItem(id: spent.id) {
                self.feedItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        cell.spended = feedItems[indexPath.row]
        
        return cell
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState) {
        switch (state) {
            case .none:
                loading.stopAnimating()
            break
            case .loading:
                loading.startAnimating()
            break

            case .success(let data):
                feedItems = data
                tableView.reloadData()
                loading.stopAnimating()
            break
            
            case .error(let msg):
                let alert = UIAlertController(title: "Controle de Gastos", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                
                loading.stopAnimating()
                
                self.present(alert, animated: true)
            break
        }
    }
}
