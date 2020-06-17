//
//  ProfileCollectionViewCell.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    var viewModel: ProfileCellViewModel?
    var profileImageView = UIImageView(image: .none)
    let profileNameLabel = UILabel(text: "이름", font: .systemFont(ofSize: 18), textColor: .black)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(profileNameLabel)
        
        profileImageView.anchor(
            .leading(contentView.leadingAnchor, constant: 15)
        )
        
        profileNameLabel.anchor(
            .leading(profileImageView.trailingAnchor, constant: 15)
        )
        
        profileImageView.centerYToSuperview()
        profileNameLabel.centerYToSuperview()
        
        profileImageView.constrainWidth(45)
        profileImageView.constrainHeight(45)
        profileNameLabel.constrainWidth(70)
        
        layer.masksToBounds = false
        layer.cornerRadius = 10
        
        setupShadow(opacity: 0.05,
                    radius: 10,
                    offset: .init(width: 0, height: 3))
        
        layer.backgroundColor = UIColor.white.cgColor
    }
}

extension ProfileCollectionViewCell: ViewModelBindableType {
    func bindViewModel(viewModel: ProfileCellViewModel) {
//        profileImageView.kf.setImage(with: viewModel.manittoImageURL)
//        profileNameLabel.text = viewModel.datas.manittoName
    }
}
