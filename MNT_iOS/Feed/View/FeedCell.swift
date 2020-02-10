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
   
    let postImageView = RoundedImageView(contentMode: .scaleAspectFill)
    let postLabel = UILabel(text: "내용", font: .systemFont(ofSize: 15), numberOfLines: 0)
    let fromtoView = FromToView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stack(
            fromtoView.withHeight(70),
            postImageView.withSize(.init(width: 200, height: 100)),
            postLabel.withHeight(20)
        )
    }
}

extension FeedCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedCellViewModel) {
        fromtoView.manittoImageView.kf.setImage(with: viewModel.manittoImageURL)
        fromtoView.targetImageView.kf.setImage(with: viewModel.targetImageURL)
        fromtoView.manittoLabel.text = viewModel.datas.userId
        //fromtoView.targetLabel.text = viewModel.datas.targetName
        postImageView.kf.setImage(with: viewModel.postURL)
    }
}
