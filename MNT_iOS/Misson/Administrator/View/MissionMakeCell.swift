//
//  MissionMakeCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit



class MissionMakeCell: UITableViewCell {
    
    override var bounds: CGRect {
        didSet {
            roundedCorner(corners: .allCorners, radius: 10)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .lightPink
    }
}
