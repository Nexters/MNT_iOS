//
//  UITextField.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

extension UITextField {
    convenience public init(placeholder: String? = nil) {
        self.init()
        self.placeholder = placeholder
    }
}
