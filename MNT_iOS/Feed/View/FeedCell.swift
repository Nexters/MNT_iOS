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
   
    let postImageView = UIImageView(contentMode: .scaleAspectFill, radius: 15)
    let postLabel = UILabel(text: "친하게 지내자 시바처럼 안녕 만나서 반가워 시바견이친하게 지내자 시바처럼",
                            font: .systemFont(ofSize: 15),
                            textColor: .contentText,
                            numberOfLines: 2)
    let fromtoView = FromToView()
    let missionTypeView = MissionTypeView()
    let moreLabel = UILabel(text: "더보기",
                        font: .systemFont(ofSize: 10),
                        textColor: .moreText,
                        textAlignment: .right)
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset = frame.width * 0.069
            var frame = newFrame
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let stackView = stack(
            fromtoView.withHeight(35),
            missionTypeView.withHeight(28),
            postImageView.withHeight(121),
            postLabel.withHeight(43),
            moreLabel.withHeight(10),
            spacing: 12
        ).withMargins(.init(top: 17,
                            left: 17,
                            bottom: 19,
                            right: 17))
        layer.masksToBounds = false
        layer.cornerRadius = 30
        setupShadow(opacity: 0.15,
                    radius: 10,
                    offset: .init(width: 0, height: 3))        
    }
}

extension FeedCell: ViewModelBindableType {
    func bindViewModel(viewModel: FeedCellViewModel) {
//        fromtoView.manittoImageView.kf.setImage(with: viewModel.manittoImageURL,
//                                                placeholder: #imageLiteral(resourceName: "group"))
//        fromtoView.targetImageView.kf.setImage(with: viewModel.targetImageURL)
        fromtoView.manittoLabel.text = viewModel.datas.userId
        //fromtoView.targetLabel.text = viewModel.datas.targetName
        postImageView.kf.setImage(with: viewModel.postURL)
    }
}
