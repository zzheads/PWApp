//
//  UIViewController +.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, style: UIAlertControllerStyle, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
