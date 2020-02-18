//
//  FeedCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var receiverImageView: UIImageView!
    @IBOutlet weak var fromtoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var viewModel: FeedCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.withMargins(.init(top: 20, left: 22, bottom: 20, right: 22))
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let isAbleImage: Bool = (viewModel?.datas.missionId?.isAbleImg == 1)
        container.roundedBorder(corners: isAbleImage ? [.bottomLeft, .bottomRight] : [.allCorners],
                                radius: 10)
    }
}

extension FeedCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
}
