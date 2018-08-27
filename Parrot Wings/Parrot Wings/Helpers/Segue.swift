//
//  Segue.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 27.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

enum Segue: String {
    case main           = "toMain"
    case register       = "toRegister"
    case transaction    = "toTransaction"
    case details        = "toTransactionDetails"
    case copy           = "toCopyTransaction"
    case unwind         = "unwindToMainController"
}
