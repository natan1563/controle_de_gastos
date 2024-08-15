//
//  FeedViewModel.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 14/08/24.
//

import UIKit

protocol FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState)
}

class FeedViewModel {
    var delegate: FeedViewModelDelegate?
    var interactor: FeedInteractor
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }
    
    var state: FeedState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func loadData() {
        interactor.fetch() { response in
            DispatchQueue.main.async {
                if let data = response {
                    self.state = .success(data)
                }
            }
        }
    }
}
