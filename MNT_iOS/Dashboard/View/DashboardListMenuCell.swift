//
//  DashboardListMenuCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

struct DashboardListMenu {
    let image: UIImage
    let text: String
    let action: () -> Void
}

class DashboardListMenuCell: UICollectionViewCell {

    var listMenu: DashboardListMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
    
    @objc private func tapAction() {
        listMenu?.action()
    }
    
    func setupView(listMenu: DashboardListMenu) {
        self.listMenu = listMenu
        
        let image = UIImageView(image: listMenu.image)
        image.tintColor = .lightGray
        image.withSize(.init(width: 24, height: 24))
        let label = UILabel(text: listMenu.text, font: .systemFont(ofSize: 15), textColor: .defaultText)
        let stack = UIStackView(arrangedSubviews: [image, label])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .leading
        addSubview(stack)
        stack.anchor(.leading(leadingAnchor, constant: 30), .bottom(bottomAnchor))
    }
}
