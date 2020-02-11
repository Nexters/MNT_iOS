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
    let manittoImageView = CircularImageView(width: 34, image: #imageLiteral(resourceName: "group"))
    let manittoLabel = UILabel(text: "마니또", font: .boldSystemFont(ofSize: 15), textColor: .defaultText)
    let targetImageView = CircularImageView(width: 34, image: #imageLiteral(resourceName: "group"))
    let targetLabel = UILabel(text: "타겟", font: .boldSystemFont(ofSize: 15))
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            manittoImageView,
            manittoLabel,
            UIImageView(image: #imageLiteral(resourceName: "arrowRight"), contentMode: .scaleAspectFit).withWidth(20),
            targetImageView,
            targetLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 9
       return sv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
            
        addSubview(stackView)
        stackView.anchor(.top(topAnchor),
                         .bottom(bottomAnchor),
                         .leading(leadingAnchor))
    }
}
