//
//  MissionMakeCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit



class MissionMakeCell: UITableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset: CGFloat = 26
            var frame = newFrame
            frame.origin.x += inset
            frame.origin.y += 5
            frame.size.width -= 2 * inset
            frame.size.height -= 2 * 5
            super.frame = frame
            roundedCorner(corners: .allCorners, radius: 10)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .lightPink
        
        let stackView = UIStackView(arrangedSubviews: [
            UIImageView(image: #imageLiteral(resourceName: "addPlus")).withSize(.init(width: 24, height: 24)),
            UILabel(text: "등록하기",
                    font: .systemFont(ofSize: 13),
                textColor: .accentColor,
                numberOfLines: 1)
            ])
        
        stackView.axis = .vertical
        stackView.withWidth(100)
        stackView.alignment = .center
        addSubview(stackView)
        
        stackView.centerInSuperview()
    }
}
