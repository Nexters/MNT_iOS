//
//  MainUserListCell.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MainUserListCell: UITableViewCell {
    
    var viewModel: RoomCheckViewModel?
    
    let profileImage = CircularImageView(width: 60, image: #imageLiteral(resourceName: "profileFace01"))
    let nameLabel = UILabel(text: "마니또",
                            font: .semiBoldFont(ofSize: 15),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    let logoutImage = UIImageView(image: #imageLiteral(resourceName: "logOut"))
    lazy var stackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        profileImage,
        nameLabel
       ])
        sv.axis = .horizontal
        sv.spacing = 0
        return sv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .lightBlue
        
        addSubview(stackView)
        addSubview(logoutImage)
        
        stackView.centerYToSuperview()
        logoutImage.centerYToSuperview()
        stackView.anchor(.leading(leadingAnchor, constant: 20))
        logoutImage.anchor(.trailing(trailingAnchor, constant: 30))
    }
}
