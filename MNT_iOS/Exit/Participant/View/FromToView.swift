//
//  FromToView.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FromToView: UIView {
    let manittoImageView = CircularImageView(width: 30, image: .none)
    let manittoLabel = UILabel(text: "마니또", font: .systemFont(ofSize: 18))
    let targetImageView = CircularImageView(width: 30, image: .none)
    let targetLabel = UILabel(text: "타겟", font: .systemFont(ofSize: 18))
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        hstack(manittoImageView,
               manittoLabel,
               UIImageView(image: nil, contentMode: .scaleAspectFit).withWidth(60),
               targetImageView,
               targetLabel)
    }
}
