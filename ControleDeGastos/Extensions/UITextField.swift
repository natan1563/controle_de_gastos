//
//  UIself.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 16/08/24.
//

import UIKit

extension UITextField {
    func addShadowBorder(){
        self.borderStyle = .roundedRect
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
    }
}
