//
//  AlertHandler.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 16/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String?, message: String?, button: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}
