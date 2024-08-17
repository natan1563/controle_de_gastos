//
//  spentedViewController.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import UIKit

class SpentViewController: UIViewController {
    private let loading: LoadingComponent = {
        let loading = LoadingComponent(style: .medium)
        loading.stopAnimating()
        
        return loading
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "O que foi comprado?"
        textField.returnKeyType = .next
        textField.addShadowBorder()
        
        // Adicionar acao de fechar o teclado quando clicar fora
        
        return textField
    }()
    
    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Valor da compra"
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        textField.addShadowBorder()
        
        return textField
    }()
    
    private lazy var purchaseDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.backgroundColor = .systemBlue
        button.setTitle("Criar", for: .normal)
        
        button.addTarget(self, action: #selector(saveSpent), for: .touchUpInside)
        
        return button
    }()
    
    var viewModel: SpentViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupNavBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        configureDismissKeyboard()
        
        navigationItem.title = "Novo Gasto"
    }
    
    func setupSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(priceTextField)
        view.addSubview(purchaseDate)
        view.addSubview(sendButton)
        view.addSubview(loading)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            priceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            priceTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            priceTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            purchaseDate.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 30),
            purchaseDate.leadingAnchor.constraint(equalTo: priceTextField.leadingAnchor),
            purchaseDate.trailingAnchor.constraint(equalTo: priceTextField.trailingAnchor),
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            
            loading.topAnchor.constraint(equalTo: view.topAnchor),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupNavBar() {
        self.tabBarItem.title = "Criar"
        self.tabBarItem.image = UIImage(systemName: "plus")
    }
    
    @objc func saveSpent() {
        if let name = nameTextField.text, name.isEmpty {
            viewModel?.state = .error("Informe o que foi comprado")
            return
        }
        
        if let price = priceTextField.text, price.isEmpty {
            viewModel?.state = .error("Informe o valor do que foi comprado")
            return
        }
        
        let dateAsString = purchaseDate.date.toString()
        if dateAsString != nil, dateAsString!.isEmpty {
            viewModel?.state = .error("Informe a data da compra")
            return
        }
        
        let feedObject = FeedObject(
            id: NSUUID().uuidString,
            name: nameTextField.text!,
            price: priceTextField.text!,
            dateAtString: dateAsString!
        )
        
        viewModel?.insertSpeend(data: feedObject)
    }
    
    func clearFields() {
        nameTextField.text = .none
        priceTextField.text = .none
        purchaseDate.date = .now
    }
}

extension SpentViewController: SpentViewModelDelegate {
    func spentDidChange(state: SpentState) {
        switch (state) {
            case .loading:
                loading.startAnimating()
            break

            case .success:
                loading.stopAnimating()
                clearFields()
                viewModel?.goToFeed()
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
