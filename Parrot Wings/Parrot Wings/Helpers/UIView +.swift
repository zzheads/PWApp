//
//  UIView +.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

extension UIView {
    func stackConfigure(_ views: [UIView], with yOffset: CGFloat, xMargin: CGFloat) {
        let height = views.compactMap({ $0.bounds.height }).reduce(0, +) + views.compactMap({ $0.layoutMargins.bottom }).reduce(0, +) + views.compactMap({ $0.layoutMargins.top }).reduce(0, +) + yOffset * CGFloat(views.count)
        var offset = -self.bounds.height / 2 + (self.bounds.height - height) / 2
        for view in views {
            if let view = view as? CheckButton {
                self.layout(view).center(offsetY: offset - yOffset)
                offset -= yOffset
            } else {
                self.layout(view).center(offsetY: offset).left(xMargin).right(xMargin)
            }
            offset += view.frame.height + view.layoutMargins.top + view.layoutMargins.bottom + yOffset
        }
    }
}
