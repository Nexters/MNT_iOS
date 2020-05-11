//
//  GrayPopUp.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/15.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class GrayPopUp: UIButton {
    required init(_ text: String) {
        super.init(frame: .zero)
        self.backgroundColor = .grayColor
        self.setTitleColor(.textOnlyColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.boldFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.withWidth(116)
        self.withHeight(40.5)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
