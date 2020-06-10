//
//  DashboardProfileCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class DashboardProfileCell: UICollectionViewCell {
    private let user: User = UserDefaults.standard.getObject(key: .user) ?? User()
    private let userFruttoID: Int = UserDefaults.standard.getIntValue(key: .userFruttoId)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView() {
        let imageview = UIImageView(image: FruitImage.sharedInstance.getFruitCircle(userFruttoID))
        
        var username = FruitImage.sharedInstance.getFruitName(userFruttoID)
        
        if UserDefaults.standard.getIntValue(key: .isOver) == 1 {
            username = (UserDefaults.standard.getObject(key: .user) ?? User()).name
        }
        
        let label = UILabel(text: "\(username)님,\n니또를 챙겨줄 때입니다!", font: .boldFont(ofSize: 20), textColor: .defaultText, numberOfLines: 2)
        
        addSubview(imageview)
        addSubview(label)
        
        imageview.anchor(.trailing(trailingAnchor, constant: 12), .height(88), .width(88))
        imageview.centerYToSuperview()
        
        label.setLineSpacing(lineSpacing: 2)
        label.anchor(.leading(leadingAnchor, constant: 26))
        label.centerYToSuperview()
    }

}
