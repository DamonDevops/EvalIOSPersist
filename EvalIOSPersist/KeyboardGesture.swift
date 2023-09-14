//
//  KeyboardGesture.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func hideonTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
