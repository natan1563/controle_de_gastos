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
                guard let data = response else {
                    self.state = .none
                    return
                }
                
                self.state = .success(data)
            }
        }
    }
    
    func removeItem(id: String) -> Bool {
        state = .loading
        let deleted = interactor.remove(id: id)
        
        if deleted {
            loadData()
        } else {
            state = .error("Falha ao remover o item, por favor tente novamente.")
        }
        
        return deleted
    }
}
