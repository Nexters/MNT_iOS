//
//  TextOnlyButton.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/15.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class TextOnlyButton: UIButton {
    required init(_ text: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.setTitleColor(.textOnlyColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .boldFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.withWidth((superview?.frame.width)! * 0.893)
        self.withHeight((superview?.frame.width)! * 0.16)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
