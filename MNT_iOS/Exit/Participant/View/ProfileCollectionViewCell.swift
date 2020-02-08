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
        
        hstack(profileImageView,
               profileNameLabel)
    }
}

extension ProfileCollectionViewCell: ViewModelBindableType {
    func bindViewModel(viewModel: ProfileCellViewModel) {
        profileImageView.kf.setImage(with: viewModel.manittoImageURL)
        profileNameLabel.text = viewModel.datas.manittoName
    }
}
