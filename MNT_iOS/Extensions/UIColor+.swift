//
//  UIColor+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

// MARK: Custom Colors
extension UIColor {
    open class var defaultText: UIColor {
        return .init(red: 34/255, green: 43/255, blue: 69/255, alpha: 1)
    }
    
    open class var contentText: UIColor {
        return .init(red: 15/255, green: 21/255, blue: 37/255, alpha: 1)
    }
    
    open class var contentImage: UIColor {
        return .init(red: 16/255, green: 20/255, blue: 38/255, alpha: 1)
    }
    
    open class var defaultShadow: UIColor {
        return .init(red: 185/255, green: 185/255, blue: 185/255, alpha: 0.5)
    }
    
    open class var accentColor: UIColor {
        return .init(red: 255/255, green: 61/255, blue: 113/255, alpha: 1)
    }
    
    open class var semiAccentColor: UIColor {
        return .init(red: 255/255, green: 168/255, blue: 180/255, alpha: 1)
    }
    
    open class var fruttoColor: UIColor {
        return .init(red: 255/255, green: 143/255, blue: 143/255, alpha: 1) // 딸기우유색,,,
    }
    
    open class var moreText: UIColor {
        return .init(red: 143/255, green: 155/255, blue: 179/255, alpha: 1)
    }
    
    open class var lightBlue: UIColor {
        return .init(red: 237/255, green: 241/255, blue: 247/255, alpha: 1)
    }
}
