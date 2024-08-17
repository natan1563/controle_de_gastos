//
//  LoadingComponent.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import UIKit

class LoadingComponent: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
