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
    let manittoLabel: UILabel = {
        let label = UILabel(text: "마니또", font: .boldSystemFont(ofSize: 15), textColor: .defaultText)
        label.withWidth(60)
        label.numberOfLines = 1
        return label
    }()
    let targetImageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "imgProfileWatermelon"))
        img.withSize(.init(width: 64, height: 64))
        return img
    }()
    let targetLabel: UILabel = UILabel(text: "타겟", font: .boldSystemFont(ofSize: 15))
    let arrowImageView = UIImageView(image: #imageLiteral(resourceName: "arrowRelation"), contentMode: .scaleToFill).withSize(.init(width: 43, height: 24))
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
            targetLabel.withWidth(70)
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
            .trailing(arrowImageView.leadingAnchor, constant: 10)
        )
        
        lStackView.centerYToSuperview()
        
        rStackView.anchor(
            .leading(arrowImageView.trailingAnchor, constant: 0),
            .trailing(trailingAnchor)
        )
        rStackView.centerYToSuperview()
    }
    
    func setupView(participant: Participant) {
        print(participant)
        let instance = FruitImage.sharedInstance
        // TODO index error....
        manittoImageView.image =  instance.getFruitCircle(participant.userFruttoId ?? 0)
        manittoLabel.text = instance.getFruitName(participant.userFruttoId ?? 0)
        targetImageView.image = instance.getProfileFace((participant.manitto?.fruttoId ?? 0))
        targetLabel.text = participant.manitto?.name ?? ""
    }
}
