//
//  CommonButton.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/12.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class AccentButton: UIButton {
    required init(_ text: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 20.0;
        self.backgroundColor = UIColor.accentColor
        self.tintColor = .white
        self.setTitle(text, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init(coder aDecoder: NSCoder){
//        super.init(coder: aDecoder)!
//        self.layer.cornerRadius = 8.0;
//        self.backgroundColor = .white
//        self.tintColor = UIColor.accentColor
//    }
}
