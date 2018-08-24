//
//  UIElements.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class UIElements {
    public final class Font {
        class func bold(with size: CGFloat) -> UIFont? {
            return UIFont(name: "RobotoCondensed-Bold", size: size)
        }
        class func regular(with size: CGFloat) -> UIFont? {
            return UIFont(name: "RobotoCondensed-Regular", size: size)
        }
        class func light(with size: CGFloat) -> UIFont? {
            return UIFont(name: "RobotoCondensed-Light", size: size)
        }
    }
    
    class func configureViewController(_ viewController: UIViewController) {
        viewController.view.backgroundColor = Color.blueGrey.lighten5
    }
    
    class func textField(_ placeholder: String?, isPassword: Bool = false) -> TextField {
        let textField = TextField()
        textField.autocapitalizationType = .none
        textField.placeholder = placeholder
        textField.font = UIElements.Font.regular(with: 12.0)
        if isPassword {
            textField.isVisibilityIconButtonEnabled = true
            textField.isVisibilityIconButtonAutoHandled = true
        }
        return textField
    }
    
    class func raisedButton(_ title: String) -> RaisedButton {
        let button = RaisedButton(title: title, titleColor: Color.blue.base)
        button.backgroundColor = Color.blue.lighten5
        button.titleLabel?.font = UIElements.Font.regular(with: 12.0)
        return button
    }
    
    class func flatButton(_ title: String) -> FlatButton {
        let button = FlatButton(title: title, titleColor: Color.blue.base)
        button.titleLabel?.font = UIElements.Font.regular(with: 11.0)
        return button
    }
    
    class func rememberMe() -> CheckButton {
        let button = CheckButton(title: "Remember me")
        button.titleLabel?.font = Font.regular(with: 11.0)
        return button
    }
    
    class func label(_ title: String? = nil, font: UIFont? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = font
        label.font = font ?? Font.regular(with: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
