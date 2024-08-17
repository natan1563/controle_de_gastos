//
//  SpeendedViewModel.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import UIKit

protocol SpentViewModelDelegate {
    func spentDidChange(state: SpentState)
}

class SpentViewModel {
    var delegate: SpentViewModelDelegate?
    var interactor: SpentInteractor
    var coordinator: SpentCoordinator

    var state: SpentState = .loading {
        didSet {
            delegate?.spentDidChange(state: state)
        }
    }
    
    init(interactor: SpentInteractor, coordinator: SpentCoordinator) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    func insertSpeend(data: FeedObject) {
        interactor.create(feedObject: data)
        state = .success
    }
    
    func goToFeed() {
        coordinator.goToFeed()
    }
}
