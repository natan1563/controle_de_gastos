//
//  LocalDataSource.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 14/08/24.
//

import Foundation

enum StorageKeys: String {
    case feedItem = "feed_item"
}

class LocalDataSource {
    static let singletonInstance = LocalDataSource()
    
    func insertItemAtList(feedItem: FeedObject) {
        let encodedItem = try? PropertyListEncoder().encode(feedItem)
        
        UserDefaults.standard.set(encodedItem, forKey: StorageKeys.feedItem.rawValue)
    }
    
    func loadItems() -> [FeedObject]? {
        if let data = UserDefaults.standard.value(forKey: StorageKeys.feedItem.rawValue) as? Data {
            let response = try? PropertyListDecoder().decode([FeedObject].self, from: data)
            
            return response
        }
        
        return nil
    }
}
