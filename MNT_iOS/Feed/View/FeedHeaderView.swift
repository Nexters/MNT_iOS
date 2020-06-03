//
//  FeedHeaderView.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/18.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedHeaderView: UIView {
    init() {
        super.init(frame: .zero)
        
        let user = UserDefaults.standard.getObject(key: .user) ?? User()
        let userFruitId = UserDefaults.standard.getObject(key: .userFruttoId) ?? 1
        let label = UILabel(text: "\(user.name),\n안녕하세요!", font: .boldFont(ofSize: 20), textColor: .defaultText, numberOfLines: 2)
        label.setLineSpacing(lineSpacing: 5)
        let profileImageview = UIImageView(image: FruitImage.sharedInstance.getFruitCircle(userFruitId))
        let randomImageviews = getDummyFruits(fruitId: userFruitId)
        
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
    
    private func getDummyFruits(fruitId: Int) -> [UIImageView] {
        let fruit1 = FruitImage.sharedInstance.getFruit(dummys[fruitId]?.0 ?? 0)
        let fruit2 = FruitImage.sharedInstance.getFruit(dummys[fruitId]?.1 ?? 0)
        return [UIImageView(image: fruit1), UIImageView(image: fruit2)]
    }
    
    private let dummys = [
        0: (14,13),
        1: (2,3),
        2: (1,3),
        3: (2,4),
        4: (5,2),
        5: (1,4),
        6: (7,11),
        7: (11, 9),
        8: (8, 6),
        9: (6, 8),
        10: (6, 7)
        ] as [Int : (Int,Int)]
}
