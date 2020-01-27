//
//  UILabel+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension UILabel {
    convenience public init(text: String? = nil, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
