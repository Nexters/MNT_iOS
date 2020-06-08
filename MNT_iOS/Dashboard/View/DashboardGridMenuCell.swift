//
//  DashboardGridMenuCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

struct DashboardGridMenu {
    var image: UIImage
    var subText: String
    var mainText: String = ""
    var type: DashboardGridMenuCell.CellType
    var tapAction: (Bool) -> Void = {_ in }
}

class DashboardGridMenuCell: UICollectionViewCell {
    
    private var gridMenu: DashboardGridMenu?
    
    override var bounds: CGRect {
        didSet {
            roundedBorder(corners: .allCorners, radius: 10)
        }
    }
    
    @objc private func tapAction() {
        isSelected = !isSelected
        toggle.image = isSelected ? #imageLiteral(resourceName: "toggleOff") : #imageLiteral(resourceName: "toggleOn")
        gridMenu?.tapAction(isSelected)
    }
    
    enum CellType {
        case normal
        case touchable
        case togglable
    }
    
    let toggle = UIImageView(image: #imageLiteral(resourceName: "toggleOn"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        
        addSubview(stackView)
        addSubview(arrow)
    }
    
    private let imageview = UIImageView()
    private let subLabel = UILabel(text: "", font: .systemFont(ofSize: 12), textColor: .lightGray)
    private let mainLabel = UILabel(text: "", font: .systemFont(ofSize: 17), textColor: .defaultText, numberOfLines: 1)
    private lazy var stackView = UIStackView(arrangedSubviews: [imageview, subLabel, mainLabel, toggle])
    private let arrow = UIImageView(image: #imageLiteral(resourceName: "chevronRight"))
    
    func setupView(gridMenu: DashboardGridMenu) {
        self.gridMenu = gridMenu
        
        imageview.image = gridMenu.image
        imageview.withSize(.init(width: 87, height: 87))
        
        subLabel.text = gridMenu.subText
        mainLabel.text = gridMenu.mainText
        mainLabel.isHidden = (gridMenu.type == .togglable)
        toggle.withSize(.init(width: 46, height: 23))
        toggle.isHidden = !(gridMenu.type == .togglable)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.centerInSuperview()
        stackView.anchor(.leading(leadingAnchor, constant: 17), .trailing(trailingAnchor, constant: 17))
        
        arrow.isHidden = !(gridMenu.type == .touchable)
        arrow.anchor(.leading(mainLabel.trailingAnchor, constant: 5))
        arrow.withSize(.init(width: 16, height: 16))
        arrow.centerYTo(mainLabel.centerYAnchor)
    }
}
