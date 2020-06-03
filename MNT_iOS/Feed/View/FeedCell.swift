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
    @IBOutlet weak var labelContainer: UIStackView!
    
    var viewModel: FeedCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelContainer.withMargins(.init(top: 20, left: 22, bottom: 20, right: 22))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let isAbleImage: Bool = (viewModel?.datas.missionId?.isAbleImg == 1 && viewModel?.datas.missionImg != nil)
        labelContainer.roundedBorder(corners: isAbleImage ? [.bottomLeft, .bottomRight] : [.allCorners], radius: 10)
        feedImageView.roundedCorner(corners: [.topLeft, .topRight], radius: 10)
        feedImageView.backgroundColor = .lightGrayBackgroundColor
    }
}

extension FeedCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
        let isAbleImage: Bool = (viewModel.datas.missionId?.isAbleImg == 1)
        labelContainer.roundedBorder(corners: isAbleImage ? [.bottomLeft, .bottomRight] : [.allCorners], radius: 10, borderWidth: 1)
        
        feedImageView.isHidden = !isAbleImage
        feedImageView.kf.setImage(with: viewModel.postURL)
        senderImageView.image = viewModel.manittoImage
        receiverImageView.image = viewModel.targetImage
        titleLabel.text = viewModel.contentTitle
        contentLabel.text = viewModel.content
        dateLabel.text = viewModel.date
        fromtoLabel.text = viewModel.fromToLabel
    }
}
