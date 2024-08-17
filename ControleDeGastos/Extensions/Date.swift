//
//  String.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 15/08/24.
//

import Foundation

extension Date {
    func toString(format: String = "dd/MM/yyyy") -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
