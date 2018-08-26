//
//  UIElements.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

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
        
    class func label(_ title: String? = nil, font: UIFont? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = font
        label.font = font ?? Font.regular(with: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
