//
//  FromToView.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

enum ArrowStyle {
    case small
}

class FromToView: UIView {
    let fromImageView = UIImageView(image: #imageLiteral(resourceName: "imgProfileChatCherry"))
    let toImageView = UIImageView(image: #imageLiteral(resourceName: "imgProfileCherry"))
    let fromtoLabel = UILabel(text: "진유진님이 지현우에게",
                              font: .boldSystemFont(ofSize: 15),
                              textColor: .defaultText)
    let dateLabel = UILabel(text: "오늘",
                            font: .systemFont(ofSize: 11),
                            textColor: .lightGray)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
            
        addSubview(toImageView)
        addSubview(fromImageView)
        fromImageView.anchor(leading: leadingAnchor, size: .init(width: 64, height: 64))
        fromImageView.centerYToSuperview()
        
        toImageView.anchor(leading: leadingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 0), size: .init(width: 64, height: 64))
        toImageView.centerYToSuperview()
        
        let stackView = UIStackView(arrangedSubviews: [fromtoLabel, dateLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.anchor(.leading(toImageView.trailingAnchor))
        stackView.centerYToSuperview()
        
    }
}
