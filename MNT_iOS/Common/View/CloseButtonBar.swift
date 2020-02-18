//
//  CloseButtonBar.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class CloseButtonBar: UIView {
    let tapCloseButtonAction: () -> Void
    
    init(title: String = "", closer: @escaping () -> Void) {
        self.tapCloseButtonAction = closer
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        let barbutton = UIButton(image: #imageLiteral(resourceName: "close"),tintColor: .defaultText, target: self, action: #selector(tapCloseButton))
        addSubview(barbutton)
        barbutton.anchor(
            .top(topAnchor, constant: 16),
            .leading(leadingAnchor, constant: 16),
            .height(24),
            .width(24)
        )
        withHeight(56)
        
        let title = UILabel(text: title, font: .boldSystemFont(ofSize: 20), textColor: .defaultText)
        addSubview(title)
        title.centerInSuperview()
    }
    
    @objc fileprivate func tapCloseButton() {
        tapCloseButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
