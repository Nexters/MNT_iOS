//
//  MainUserListCell.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MainUserListCell: UITableViewCell {
    
//    var viewModel: MainUserListCellViewModel?
    var viewModel : MainUserListViewModel?
    
    let profileImage = CircularImageView(width: 60, image: #imageLiteral(resourceName: "profileFace01"))
    let nameLabel = UILabel(text: "마니또",
                            font: .semiBoldFont(ofSize: 15),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    var deleteButton = UIButton(image: #imageLiteral(resourceName: "logOut"),
                                tintColor: .gray)
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
        
        addSubview(stackView)
//        addSubview(deleteButton)
        
        stackView.centerYToSuperview()
//        deleteButton.centerYToSuperview()
        stackView.anchor(.leading(leadingAnchor, constant: 20))
//        deleteButton.anchor(.trailing(trailingAnchor, constant: 30))
        nameLabel.constrainWidth(180)
        
//        self.deleteButton.addTarget(self,
//                                    action: #selector(buttonTapped(_:)),
//                                    for: .touchUpInside)
    }
}
