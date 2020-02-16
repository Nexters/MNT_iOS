//
//  UIFont+.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/16.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

// MARK: Custom Colors
extension UIFont {
    
    open class func boldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Bold", size: fontSize)!
    }
    
    open class func semiBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-SemiBold", size: fontSize)!
    }
    
    open class func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Medium", size: fontSize)!
    }
    
    open class func subMediumFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Medium", size: fontSize)!
    }
    
    open class func subSemiBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: fontSize)!
    }
}
