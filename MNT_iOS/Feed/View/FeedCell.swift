//
//  FeedCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    var viewModel: FeedCellViewModel?
    let manittoImageView = CircularImageView(width: 30, image: .none)
    let manittoLabel = UILabel(text: "마니또", font: .systemFont(ofSize: 18))
    let targetImageView = CircularImageView(width: 30, image: .none)
    let targetLabel = UILabel(text: "타겟", font: .systemFont(ofSize: 18))
    let postImageView = RoundedImageView(contentMode: .scaleAspectFill)
    let postLabel = UILabel(text: "내용", font: .systemFont(ofSize: 15), numberOfLines: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stack(
            hstack(manittoImageView,
                   manittoLabel,
                   UIImageView(image: nil, contentMode: .scaleAspectFit).withWidth(60),
                   targetImageView,
                   targetLabel).withHeight(70),
            postImageView.withSize(.init(width: 200, height: 100)),
            postLabel.withHeight(20)
        )
    }
}

extension FeedCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedCellViewModel) {
        manittoImageView.kf.setImage(with: viewModel.manittoImageURL)
        targetImageView.kf.setImage(with: viewModel.targetImageURL)
        manittoLabel.text = viewModel.datas.manittoName
        targetLabel.text = viewModel.datas.targetName
        postImageView.kf.setImage(with: viewModel.postURL)
    }
}
