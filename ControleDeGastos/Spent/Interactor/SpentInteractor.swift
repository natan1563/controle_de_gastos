//
//  SpentInteractor.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import Foundation

class SpentInteractor {
    private var localDataSource: LocalDataSource = .singletonInstance
    
    func create(feedObject: FeedObject) {
        localDataSource.insertItemAtList(feedItem: feedObject)
    }
    
    func loadData() -> [FeedObject]? {
        return localDataSource.loadItems()
    }
}
