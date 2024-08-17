//
//  FeedState.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 14/08/24.
//

import Foundation

enum FeedState {
    case none
    case loading
    case success([FeedObject])
    case error(String)
}
