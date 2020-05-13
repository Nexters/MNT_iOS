//
//  CustomNavigationBar.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class CustomBar: UIView {
    var tapCloseButtonAction = (() -> Void).self
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let barbutton = UIButton(image: #imageLiteral(resourceName: "close"),tintColor: .defaultText, target: self, action: #selector(tapCloseButton))
        
    }
    
    @objc fileprivate func tapCloseButton() {
        tapCloseButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
