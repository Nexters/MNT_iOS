//
//  UserListCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    let manittoImageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "imgProfileBanana"))
        img.withSize(.init(width: 64, height: 64))
        return img
    }()
    let manittoLabel = UILabel(text: "마니또", font: .boldSystemFont(ofSize: 15), textColor: .defaultText)
      let targetImageView: UIImageView = {
          let img = UIImageView(image: #imageLiteral(resourceName: "imgProfileWatermelon"))
          img.withSize(.init(width: 64, height: 64))
          return img
      }()
    let targetLabel = UILabel(text: "타겟", font: .boldSystemFont(ofSize: 15))
    let arrowImageView = UIImageView(image: #imageLiteral(resourceName: "arrowRelation"), contentMode: .scaleAspectFit).withSize(.init(width: 43, height: 24))
    lazy var lStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            manittoImageView,
            manittoLabel
        ])
        sv.axis = .horizontal
        return sv
    }()
    lazy var rStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            targetImageView,
            targetLabel
        ])
        sv.axis = .horizontal
        return sv
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(arrowImageView)
        addSubview(lStackView)
        addSubview(rStackView)
        arrowImageView.centerInSuperview()
        
        lStackView.anchor(
            .leading(leadingAnchor, constant: 0),
            .trailing(arrowImageView.leadingAnchor, constant: 5)
        )
        lStackView.centerYToSuperview()
        
        rStackView.anchor(
            .leading(arrowImageView.trailingAnchor),
            .trailing(trailingAnchor)
        )
        rStackView.centerYToSuperview()
    }
}
