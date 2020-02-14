//
//  UserListCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    let manittoImageView = CircularImageView(width: 40, image: #imageLiteral(resourceName: "group2"))
    let manittoLabel = UILabel(text: "마니또", font: .boldSystemFont(ofSize: 16), textColor: .defaultText)
    let targetImageView = CircularImageView(width: 40, image: #imageLiteral(resourceName: "group2"))
    let targetLabel = UILabel(text: "타겟", font: .boldSystemFont(ofSize: 16))
    let arrowImageView = UIImageView(image: #imageLiteral(resourceName: "arrowRight"), contentMode: .scaleAspectFit).withSize(.init(width: 24, height: 24))
    lazy var lStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            manittoImageView,
            manittoLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 12
        return sv
    }()
    lazy var rStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            targetImageView,
            targetLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 12
        return sv
    }()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset = frame.width * 0.0861
            var frame = newFrame
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 15
        backgroundColor = .lightBlue
        
        addSubview(arrowImageView)
        addSubview(lStackView)
        addSubview(rStackView)
        
        arrowImageView.centerInSuperview()
        
        lStackView.anchor(
            .leading(leadingAnchor, constant: 16),
            .trailing(arrowImageView.leadingAnchor, constant: 9)
        )
        lStackView.centerYToSuperview()
        
        rStackView.anchor(
            .leading(arrowImageView.trailingAnchor, constant: 10),
            .trailing(trailingAnchor, constant: 20)
        )
        rStackView.centerYToSuperview()
    }
}
