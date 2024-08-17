//
//  FeedInteractor.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 14/08/24.
//

import Foundation

class FeedInteractor {
    private let local: LocalDataSource = .singletonInstance
    
    func fetch(completion: @escaping([FeedObject]?) -> Void) {
        completion(local.loadItems())
    }
    
    func remove(id: String) -> Bool {
        return local.removeItem(id: id)
    }
}
