//
//  StackChildView.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/06.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class StackChildView: UIView {
    var propotionalHeight = 1.0
    var propotionalWidth = 1.0
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: propotionalWidth, height: propotionalHeight)
    }
}
