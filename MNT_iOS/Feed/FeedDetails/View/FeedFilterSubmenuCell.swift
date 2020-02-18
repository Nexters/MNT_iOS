//
//  FeedFilterSubmenuCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FeedFilterSubmenuCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public func setupLayout(menu: FeedFilterSubMenu) {
        imageview.image = menu.image
        label.text = menu.text
        selectedBackgroundView = UIView(backgroundColor: .white)
    }
}
