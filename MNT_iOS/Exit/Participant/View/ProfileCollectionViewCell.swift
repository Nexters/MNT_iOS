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
    let profileImageView = CircularImageView(width: 30, image: .none)
    let profileNameLabel = UILabel(text: "이름", font: .systemFont(ofSize: 18), textColor: .black)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        hstack(
            profileImageView.withWidth(30)
                            .withHeight(30),
            profileNameLabel.withWidth(75),
            spacing: 15)
            .withMargins(.init(top: 0,
                               left: 15,
                               bottom: 0,
                               right: 0))
        
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
        profileImageView.kf.setImage(with: viewModel.manittoImageURL)
        profileNameLabel.text = viewModel.datas.manittoName
    }
}
