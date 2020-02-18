//
//  FeedFilterCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/18.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FeedFilterCell: UITableViewCell {
    
    var viewModel: FeedFilterCellViewModel?
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset: CGFloat = 26
            var frame = newFrame
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
  
    fileprivate lazy var container = UIView(backgroundColor: .unselectedCellColor)
    fileprivate let filterMenuLabel = UILabel(text: "미션별로 보기", font: .boldSystemFont(ofSize: 15), textColor: .defaultText)
    fileprivate let expandImageview = UIImageView(image: #imageLiteral(resourceName: "chevronDown"))
    fileprivate var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView(backgroundColor: .white)
        
        addSubview(container)
        container.layer.cornerRadius = 10
        container.anchor(.top(topAnchor), .leading(leadingAnchor), .trailing(trailingAnchor), .height(67))
        expandImageview.isHidden = true
        
        addSubview(filterMenuLabel)
        addSubview(expandImageview)
        filterMenuLabel.anchor(.leading(container.leadingAnchor, constant: 24))
        filterMenuLabel.centerYTo(container.centerYAnchor)
        expandImageview.anchor(.trailing(container.trailingAnchor, constant: 14))
        expandImageview.centerYTo(container.centerYAnchor)
    }
    
    func expand() {
        DispatchQueue.main.async {
            self.expandImageview.image = #imageLiteral(resourceName: "chevronUp")
            self.container.backgroundColor = .selectedCellColor
        }
    }
    
    func collapse() {
        DispatchQueue.main.async {
            self.expandImageview.image = #imageLiteral(resourceName: "chevronDown")
            self.container.backgroundColor = .unselectedCellColor
        }
    }
}

extension FeedFilterCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedFilterCellViewModel) {
        filterMenuLabel.text = viewModel.filtername
        
        if viewModel.subMenus.count > 0 {
            self.expandImageview.isHidden = false
        }
    }
}

struct FeedFilterCellViewModel {
    var filtername: String = ""
    var subMenus: [FeedFilterSubMenu] = []
}

struct FeedFilterSubMenu {
    var image: UIImage = #imageLiteral(resourceName: "people")
    var text: String = ""
}


