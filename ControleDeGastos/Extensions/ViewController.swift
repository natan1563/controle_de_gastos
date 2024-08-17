//
//  ViewController.swift
//  ControleDeGastos
//
//  Created by Natã Romão on 17/08/24.
//

import UIKit

extension UIViewController {
    func configureKeyboard(handle: KeyboardHandle) {
        NotificationCenter.default.addObserver(
            handle,
            selector: #selector(handle.onKeyboardNotification),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            handle,
            selector: #selector(handle.onKeyboardNotification),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func configureDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
