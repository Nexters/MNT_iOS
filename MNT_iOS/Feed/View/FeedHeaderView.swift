//
//  FeedHeaderView.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/18.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedHeaderView: UIView {
    init(user: User) {
        super.init(frame: .zero)
        
        let label = UILabel(text: "포도링님,\n안녕하세요!", font: .boldFont(ofSize: 20), textColor: .defaultText, numberOfLines: 2)
        label.setLineSpacing(lineSpacing: 5)
        let profileImageview = UIImageView(image: #imageLiteral(resourceName: "imgProfileOrange"))
        let randomImageviews = [UIImageView(image: #imageLiteral(resourceName: "imgProfileIconRedapple")), UIImageView(image: #imageLiteral(resourceName: "imgProfileIconCherry"))]
        
        addSubview(label)
        
        randomImageviews.forEach {
            addSubview($0)
            $0.withSize(.init(width: 64, height: 64))
            $0.centerYToSuperview()
        }
        
        addSubview(profileImageview)
    
        label.anchor(
            .top(topAnchor, constant: 0),
            .leading(leadingAnchor, constant: 26)
        )
        
        
        randomImageviews[0].anchor(.trailing(trailingAnchor, constant: 6))
        randomImageviews[1].anchor(.trailing(trailingAnchor, constant: 25))
        profileImageview.withSize(.init(width: 64, height: 64))
        profileImageview.anchor(.trailing(trailingAnchor, constant: 54))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
